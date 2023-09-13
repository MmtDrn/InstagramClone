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

protocol PostManagerProtocol {
    func shareImage(shareType: ShareType,
                          image: UIImage,
                          description: String?,
                          completion: @escaping(Result<Bool,Error>) -> Void)
    func setPostData(postURL: String,
                             description: String?,
                             likeCount: String?)
    func getAllPosts(completion: @escaping([PostModel]?,Error?) -> Void)
    func getPostData(uid: String, completion: @escaping([PostModel]?,Error?) -> Void)
    func followedPosts(follwedPersons: [String], completion: @escaping([PostModel]?,FetchError?) -> Void)
}

class FirebasePostManager: PostManagerProtocol {
    
    static let shared = FirebasePostManager()
    private init() {}
    
    public func shareImage(shareType: ShareType,
                          image: UIImage,
                          description: String?,
                          completion: @escaping(Result<Bool,Error>) -> Void) {
        UIApplication.getTopViewController()?.view.isUserInteractionEnabled = false
        UIApplication.getTopViewController()?.navigationController?.navigationBar.isUserInteractionEnabled = false
        ProgressHUD.show()
        
        if let data = image.jpegData(compressionQuality: 1) {
            let uuid = UUID().uuidString
            
            let imageReferance = PostStorage.post(uid: uuid).imageReferance
            imageReferance.putData(data) { (metadata, error) in
                if let error {
                    completion(.failure(error))
                } else {
                    ProgressHUD.dismiss()
                    imageReferance.downloadURL { (url, error) in
                        guard let url else { return }
                        switch shareType {
                        case .post:
                            self.setPostData(postURL: url.absoluteString,
                                             description: description,
                                             likeCount: nil)
                        case .profilImage:
                            FirebaseUserDataManager.shared.updateUserData(userDataType: .profilImageUrl,
                                                                      data: url.absoluteString)
                        }
                    }
                    completion(.success(true))
                }
            }
        }
    }
    
    
    func setPostData(postURL: String,
                             description: String?,
                             likeCount: String?) {
        guard let uid = Defs.shared.userModel?.uuid else { return }
        let data: [String : Any] = [PostDataTag.postURL: postURL,
                                    PostDataTag.description : description,
                                    PostDataTag.likeCount : likeCount,
                                    PostDataTag.author : uid,
                                    PostDataTag.date : Date().stringValue()]
        

        Collections.postData(uid: uid).collection.addDocument(data: data)
        Collections.allPosts.collection.addDocument(data: data)
    }
    
    public func getAllPosts(completion: @escaping([PostModel]?,Error?) -> Void) {
        var posts = [PostModel]()
        
        Collections.allPosts.collection.getDocuments { (snapShot, error) in
            if let error {
                completion(nil, error)
            }
            
            for document in snapShot!.documents {
                let data = document.data()
                
                if let postURL = data[PostDataTag.postURL] as? String,
                   let date = data[PostDataTag.date] as? String,
                   let author = data[PostDataTag.author] as? String {
                    var post = PostModel(authorUID: author, postURL: postURL, description: nil, likeCount: nil, date: date)
                    if let likeCount = data[PostDataTag.likeCount] as? String {
                        post.likeCount = likeCount
                    }
                    
                    if let description = data[PostDataTag.description] as? String {
                        post.description = description
                    }
                    posts.append(post)
                }
                
            }
            completion(posts, nil)
        }
    }
    
    public func getPostData(uid: String, completion: @escaping([PostModel]?,Error?) -> Void) {

        var posts = [PostModel]()
        
        Collections.postData(uid: uid).collection.getDocuments { (snapShot, error) in
            if let error {
                completion(nil, error)
            }
            
            for document in snapShot!.documents {
                let data = document.data()
                
                if let postURL = data[PostDataTag.postURL] as? String,
                   let date = data[PostDataTag.date] as? String,
                   let author = data[PostDataTag.author] as? String {
                    var post = PostModel(authorUID: author, postURL: postURL, description: nil, likeCount: nil, date: date)
                    if let likeCount = data[PostDataTag.likeCount] as? String {
                        post.likeCount = likeCount
                    }
                    
                    if let description = data[PostDataTag.description] as? String {
                        post.description = description
                    }
                    posts.append(post)
                }
                
            }
            completion(posts, nil)
        }
    }
    
    public func followedPosts(follwedPersons: [String], completion: @escaping([PostModel]?,FetchError?) -> Void) {
        var posts = [PostModel]()
        let group = DispatchGroup()
        
        for person in follwedPersons {
            group.enter()
            Collections.postData(uid: person).collection.getDocuments { (snapShot, error) in
                defer {
                    group.leave()
                }
                if let _ = error {
                    completion(nil, .backendError)
                } else if let snapShot {
                    for document in snapShot.documents {
                        let data = document.data()
                        
                        if let postURL = data[PostDataTag.postURL] as? String,
                           let date = data[PostDataTag.date] as? String,
                           let author = data[PostDataTag.author] as? String {
                            var post = PostModel(authorUID: author, postURL: postURL, description: nil, likeCount: nil, date: date)
                            if let likeCount = data[PostDataTag.likeCount] as? String {
                                post.likeCount = likeCount
                            }
                            
                            if let description = data[PostDataTag.description] as? String {
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
