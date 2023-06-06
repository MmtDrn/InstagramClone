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
                guard let result = result else { return }
                self.getUserDatas(uid: result.user.uid)
                completion(.success(true))
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
        var fireStoreReferance : DocumentReference? = nil
        
        fireStoreReferance = fireStoreDatabase.collection("users").document("\(uid)userData").collection("data").addDocument(data: data, completion: { error in
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

    private func getUserDatas(uid: String) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document("\(uid)userData").collection("data").getDocuments { (snapShot, error) in
            if let error {
                print(error.localizedDescription)
            } else {
                for document in snapShot!.documents {
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
                }
            }
        }
    }
    
    
    
    func updateUserData<T>(userDataType: UserDataType, data: T) {
        let db = Firestore.firestore()
        
        db.collection("users").document("\(Defs.shared.userModel?.uuid ?? "")userData").collection("data").getDocuments { (snapShot, error) in
            if error == nil {
                snapShot?.documents.first?.reference.setData([userDataType.path : data], merge: true)
                switch userDataType {
                case .uid:
                    guard let data = data as? String else { return }
                    Defs.shared.userModel?.uuid = data
                case .email:
                    guard let data = data as? String else { return }
                    Defs.shared.userModel?.email = data
                case .fullName:
                    guard let data = data as? String else { return }
                    Defs.shared.userModel?.fullName = data
                case .phoneNumber:
                    guard let data = data as? String else { return }
                    Defs.shared.userModel?.phoneNumber = data
                case .userName:
                    guard let data = data as? String else { return }
                    Defs.shared.userModel?.userName = data
                case .profilImageUrl:
                    guard let data = data as? String else { return }
                    Defs.shared.userModel?.profilImageURL = data
                case .followers:
                    guard let data = data as? [String] else { return }
                    Defs.shared.userModel?.followerUID = data
                case .followed:
                    guard let data = data as? [String] else { return }
                    Defs.shared.userModel?.followingUID = data
                }
            }
        }
    }
    
    func getUserdata(userDataType: UserDataType, uid: String, completion: @escaping(Any?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("users").document("\(uid)userData").collection("data").getDocuments { (snapShot, error) in
            if let error {
                completion(nil, error)
            } else {
                guard let snapShot,
                      let dataRef = snapShot.documents.first?.data() else { return }
                
                switch userDataType {
                case .followed, .followers:
                    if let data = dataRef[userDataType.path] as? [String] {
                        completion(data, nil)
                    }
                default:
                    if let data = dataRef[userDataType.path] as? String {
                        completion(data, nil)
                    }
                }
            }
        }
    }
    
    
}
