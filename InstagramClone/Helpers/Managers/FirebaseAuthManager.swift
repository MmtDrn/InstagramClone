//
//  FirebaseManager.swift
//  InstagramClone
//
//  Created by mehmet duran on 2.06.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    private init() {}
    
    
    public func userRegister(model: RegisterModel, completion: @escaping(Result<Bool, RegisterError>)-> Void) {
        let validationManager = ValidationManager.shared
        guard let name = model.fullName,
              let userName = model.userName,
              let email = model.email,
              let phoneNumber = model.phoneNumber,
              let password = model.password,
              let passwordAgain = model.passwordAgain else {
            completion(.failure(.missinField))
            return
        }
        
        if !validationManager.validate(name: name) {
            completion(.failure(.name))
        } else if !validationManager.validate(email: email) {
            completion(.failure(.email))
        } else if !validationManager.validate(phone: phoneNumber) {
            completion(.failure(.phoneNumber))
        } else if !validationManager.validate(password: password) {
            completion(.failure(.password))
        } else if password != passwordAgain {
            completion(.failure(.matchPasswords))
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
              if error != nil {
                  completion(.failure(.backend))
              } else {
                  self.setUserData(uid: (result?.user.uid)!,
                                   email: email,
                                   fullName: name,
                                   userName: userName,
                                   phoneNumber: phoneNumber,
                                   profilImageURL: nil,
                                   followingUID: nil,
                                   followerUID: nil) { result, error in
                      if let _ = error {
                          completion(.failure(.setUserData))
                      } else {
                          completion(.success(true))
                      }
                  }
              }
          }
        }
    }
    
    public func logIn(email: String, password: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let error {
                completion(.failure(error))
            } else {
                guard let result else { return }
                self.getUserDatas(uid: result.user.uid) { result in
                    switch result {
                    case .success(_):
                        completion(.success(true))
                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                }
                
            }
        }
    }
    
    public func logOut(completion: @escaping(Result<Bool, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    private func setUserData(uid: String,
                             email: String,
                             fullName: String,
                             userName: String,
                             phoneNumber: String,
                             profilImageURL: String?,
                             followingUID: [String]?,
                             followerUID: [String]?,
                             completion: @escaping(Bool?, RegisterError?) -> Void) {
        
        let data: [String : Any] = ["uuid": uid,
                                    "email" : email,
                                    "fullName" : fullName,
                                    "userName" : userName,
                                    "phoneNumber" : phoneNumber,
                                    "profilImageURL" : profilImageURL,
                                    "followingUID" : followingUID,
                                    "followerUID" : followerUID]
        
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("allUser").addDocument(data: ["uid": uid])
        fireStoreDatabase.collection("users").document("\(uid)userData").collection("data").addDocument(data: data, completion: { error in
            if let _ = error {
                completion(nil, .setUserData)
            } else {
                Defs.shared.userModel = DefsUserModel(uuid: uid,
                                                      fullName: fullName,
                                                      userName: userName,
                                                      email: email,
                                                      phoneNumber: phoneNumber,
                                                      profilImageURL: nil,
                                                      followerUID: nil,
                                                      followingUID: nil)
                completion(true, nil)
            }
        })
    }

    private func getUserDatas(uid: String, completion: @escaping(Result<Bool,Error>)-> Void) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document("\(uid)userData").collection("data").getDocuments { (snapShot, error) in
            if let error {
                completion(.failure(error))
            } else if let document = snapShot?.documents.first {
                
                let data = document.data()
                
                if let email = data["email"] as? String,
                   let fullName = data["fullName"] as? String,
                   let phoneNumber = data["phoneNumber"] as? String,
                   let userName = data["userName"] as? String,
                   let uuid = data["uuid"] as? String {
                    
                    Defs.shared.userModel = DefsUserModel(uuid: uuid,
                                                          fullName: fullName,
                                                          userName: userName,
                                                          email: email,
                                                          phoneNumber: phoneNumber)
                }
                
                if let profilImageURL = data["profilImageURL"] as? String {
                    self.updateUserData(userDataType: .profilImageUrl, data: profilImageURL)
                    Defs.shared.userModel?.profilImageURL = profilImageURL
                }
                
                if let followers = data["followerUID"] as? [String] {
                    self.updateUserData(userDataType: .followers, data: followers)
                    Defs.shared.userModel?.followerUID = followers
                }
                
                if let following = data["followingUID"] as? [String] {
                    self.updateUserData(userDataType: .followed, data: following)
                    Defs.shared.userModel?.followingUID = following
                }
                completion(.success(true))
            } else {
                completion(.failure(FetchError.backendError))
            }
        }
    }
    
    
    
    func updateUserData<T>(userDataType: UserDataType, data: T) {
        let db = Firestore.firestore()
        guard let selfUID = Defs.shared.userModel?.uuid,
              let setData = data as? String else { return }

        
        db.collection("users").document("\(selfUID)userData").collection("data").getDocuments { (snapShot, error) in
            if error == nil {
                
                switch userDataType {
                case .followed, .followers:
                    // CURRENT USER
                    
                    /// current user followings are download from db
                    self.getUserdata(userDataType: .followed,
                                     uid: selfUID) { (data:[String]?, error: FetchError?) in
                        if data != nil || error == .noneItem {
                            var setArray = [String]()
                            if let data { setArray = data }
                            setArray.append(setData)
                            /// current user's new following are uploaded to db
                            snapShot?.documents.first?.reference.setData([userDataType.path : setArray],
                                                                         merge: true, completion: { error in
                                if error == nil {
                                    db.collection("users").document("\(setData)userData").collection("data").getDocuments { (snapShot, error) in
                                        if error == nil {
                                            // COUNTER USER
                                            
                                            /// counter user followers are download from db
                                            self.getUserdata(userDataType: .followers,
                                                             uid: setData) { (data:[String]?, error: FetchError?) in
                                                if let data {
                                                    var setArray = data
                                                    setArray.append(selfUID)
                                                    /// counter user's new followers are uploaded to db
                                                    snapShot?.documents.first?.reference.setData([UserDataType.followers.path : setArray], merge: true)
                                                } else if error == .noneItem {
                                                    var setArray: [String] = []
                                                    setArray.append(selfUID)
                                                    /// counter user's new followers are uploaded to db
                                                    snapShot?.documents.first?.reference.setData([UserDataType.followers.path : setArray], merge: true)
                                                }
                                            }
                                        }
                                    }
                                }
                            })
                            /// current user's new following are uploaded to userDefault
                            Defs.shared.userModel?.followingUID?.append(setData)
                        }
                    }

                default:
                    snapShot?.documents.first?.reference.setData([userDataType.path : data], merge: true, completion: { error in
                        if error == nil {
                            switch userDataType {
                            case .uid:
                                Defs.shared.userModel?.uuid = setData
                            case .email:
                                Defs.shared.userModel?.email = setData
                            case .fullName:
                                Defs.shared.userModel?.fullName = setData
                            case .phoneNumber:
                                Defs.shared.userModel?.phoneNumber = setData
                            case .userName:
                                Defs.shared.userModel?.userName = setData
                            case .profilImageUrl:
                                Defs.shared.userModel?.profilImageURL = setData
                            default:
                                break
                            }
                        }
                    })
                }
            }
        }
    }
    
    func getUserdata<T>(userDataType: UserDataType, uid: String, completion: @escaping(T?, FetchError?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("users").document("\(uid)userData").collection("data").getDocuments { (snapShot, error) in
            if let _ = error {
                completion(nil, .backendError)
            } else {
                guard let snapShot,
                      let dataRef = snapShot.documents.first?.data() else { return }
                
                if let data = dataRef[userDataType.path] as? T {
                    completion(data, nil)
                } else {
                    completion(nil, .noneItem)
                }
            }
        }
    }
    
    public func getAllUsers(completion: @escaping([String]?, FetchError?) -> Void) {
        let db = Firestore.firestore()
        let usersRef = db.collection("allUser")
        
        usersRef.getDocuments { (snapShot, error) in

            if let _ = error {
                completion(nil, .backendError)
            } else if let snapShot {
                if snapShot.documents.isEmpty {
                    completion(nil, .noneItem)
                } else {
                    var users: [String] = []
                    for document in snapShot.documents {
                        let data = document.data()
                        let user = data["uid"] as? String
                        users.append(user!)
                    }
                    completion(users, nil)
                }
            }
        }
    }
}
