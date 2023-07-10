//
//  FirebasePostManager.swift
//  InstagramClone
//
//  Created by mehmet duran on 2.06.2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import ProgressHUD

class FirebasePostManager {
    
    static let shared = FirebasePostManager()
    private init() {}
    
    public func shareImage(shareType: ShareType,
                          image: UIImage,
                          description: String?,
                          completion: @escaping(Result<Bool,Error>) -> Void) {
        UIApplication.getTopViewController()?.view.isUserInteractionEnabled = false
        UIApplication.getTopViewController()?.navigationController?.navigationBar.isUserInteractionEnabled = false
        ProgressHUD.show()
        
        let storageReferance = Storage.storage().reference()
        let mediaFolder = storageReferance.child("posts")
        
        if let data = image.jpegData(compressionQuality: 1) {
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data) { (metadata, error) in
                if let error {
                    completion(.failure(error))
                } else {
                    ProgressHUD.dismiss()
                    imageReferance.downloadURL { (url, error) in
                        guard let url else { return }
                        switch shareType {
                        case .post:
                            self.setPostData(postURL: url.absoluteString, description: description, likeCount: nil)
                        case .profilImage:
                            FirebaseAuthManager.shared.updateUserData(userDataType: .profilImageUrl,
                                                                      data: url.absoluteString)
                        }
                    }
                    completion(.success(true))
                }
            }
        }
    }
    
    
    private func setPostData(postURL: String,
                             description: String?,
                             likeCount: String?) {
        guard let uid = Defs.shared.userModel?.uuid else { return }
        let data: [String : Any] = ["postURL": postURL,
                                    "description" : description,
                                    "likeCount" : likeCount,
                                    "author" : uid,
                                    "date" : Date().stringValue()]
        
        let fireStoreDatabase = Firestore.firestore()
        var fireStoreReferance : DocumentReference? = nil
        
        fireStoreReferance = fireStoreDatabase.collection("postData").document("\(uid)postData").collection("sharePosts").addDocument(data: data)
    }
    
    public func getPostData(uid: String, completion: @escaping([PostModel]?,Error?) -> Void) {
        let db = Firestore.firestore()
        var posts = [PostModel]()
        
        db.collection("postData").document("\(uid)postData").collection("sharePosts").getDocuments { (snapShot, error) in
            if let error {
                completion(nil, error)
            }
            
            for document in snapShot!.documents {
                let data = document.data()
                
                if let postURL = data["postURL"] as? String,
                   let date = data["date"] as? String,
                   let author = data["author"] as? String {
                    var post = PostModel(authorUID: author, postURL: postURL, description: nil, likeCount: nil, date: date)
                    if let likeCount = data["likeCount"] as? String {
                        post.likeCount = likeCount
                    }
                    
                    if let description = data["description"] as? String {
                        post.description = description
                    }
                    posts.append(post)
                }
                
            }
            completion(posts, nil)
        }
    }
    
    public func followedPosts(follwedPersons: [String], completion: @escaping([PostModel]?,FetchError?) -> Void) {
        let db = Firestore.firestore()
        var posts = [PostModel]()
        let group = DispatchGroup()
        
        for person in follwedPersons {
            group.enter()
            db.collection("postData").document("\(person)postData").collection("sharePosts").getDocuments { (snapShot, error) in
                defer {
                    group.leave()
                }
                if let _ = error {
                    completion(nil, .backendError)
                } else if let snapShot {
                    for document in snapShot.documents {
                        let data = document.data()
                        
                        if let postURL = data["postURL"] as? String,
                           let date = data["date"] as? String,
                           let author = data["author"] as? String {
                            var post = PostModel(authorUID: author, postURL: postURL, description: nil, likeCount: nil, date: date)
                            if let likeCount = data["likeCount"] as? String {
                                post.likeCount = likeCount
                            }
                            
                            if let description = data["description"] as? String {
                                post.description = description
                            }
                            posts.append(post)
                        }
                        
                    }
                }
            }
        }
        group.notify(queue: .main) {
            let sortedPosts = posts.sorted { (model1, model2) in
                guard let date1 = model1.date?.toDate(),
                      let date2 = model2.date?.toDate() else {
                    return false
                }
                return date1 > date2
            }
            if sortedPosts.isEmpty {
                completion(nil, .noneItem)
            } else {
                completion(sortedPosts, nil)
            }
        }
    }
}
