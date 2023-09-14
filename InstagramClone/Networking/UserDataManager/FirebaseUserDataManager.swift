//
//  FirebaseUserDataManager.swift
//  InstagramClone
//
//  Created by mehmet duran on 13.09.2023.
//

import Foundation

class FirebaseUserDataManager: UserDataManagerProtocol {
    
    static let shared = FirebaseUserDataManager()
    private init() { }
    
   func setUserDataToDB(uid: String,
                             email: String,
                             fullName: String,
                             userName: String,
                             phoneNumber: String,
                             profilImageURL: String?,
                             followingUID: [String]?,
                             followerUID: [String]?,
                             completion: @escaping(Bool?, RegisterError?) -> Void) {
        
        let data: [String : Any] = [UserDataTag.uuid: uid,
                                    UserDataTag.email : email,
                                    UserDataTag.fullName : fullName,
                                    UserDataTag.userName : userName,
                                    UserDataTag.phoneNumber : phoneNumber,
                                    UserDataTag.profilImageURL : profilImageURL,
                                    UserDataTag.followingUID : followingUID,
                                    UserDataTag.followerUID : followerUID]
                
        Collections.allUsers.collection.addDocument(data: [AllUserTag.uuid: uid])
        Collections.users(uid: uid).collection.addDocument(data: data, completion: { error in
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

    func getUserDatas(uid: String, completion: @escaping(Result<Bool,Error>)-> Void) {
            
        Collections.users(uid: uid).collection.getDocuments { (snapShot, error) in
            if let error {
                completion(.failure(error))
            } else if let document = snapShot?.documents.first {
                
                let data = document.data()
                
                if let email = data[UserDataTag.email] as? String,
                   let fullName = data[UserDataTag.fullName] as? String,
                   let phoneNumber = data[UserDataTag.phoneNumber] as? String,
                   let userName = data[UserDataTag.userName] as? String,
                   let uuid = data[UserDataTag.uuid] as? String {
                    
                    Defs.shared.userModel = DefsUserModel(uuid: uuid,
                                                          fullName: fullName,
                                                          userName: userName,
                                                          email: email,
                                                          phoneNumber: phoneNumber)
                }
                
                if let profilImageURL = data[UserDataTag.profilImageURL] as? String {
                    self.updateUserData(userDataType: .profilImageUrl, data: profilImageURL)
                    Defs.shared.userModel?.profilImageURL = profilImageURL
                }
                
                if let followers = data[UserDataTag.followerUID] as? [String] {
                    self.updateUserData(userDataType: .followers, data: followers)
                    Defs.shared.userModel?.followerUID = followers
                }
                
                if let following = data[UserDataTag.followingUID] as? [String] {
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
        guard let selfUID = Defs.shared.userModel?.uuid,
              let setData = data as? String else { return }

        
        Collections.users(uid: selfUID).collection.getDocuments { (snapShot, error) in
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
                                    Collections.users(uid: setData).collection.getDocuments { (snapShot, error) in
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
                            Defs.shared.userModel?.setData(dataType: userDataType, data: setData)
                        }
                    })
                }
            }
        }
    }
    
    func getUserdata<T>(userDataType: UserDataType, uid: String, completion: @escaping(T?, FetchError?) -> Void) {
        
        Collections.users(uid: uid).collection.getDocuments { (snapShot, error) in
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
    
    func getAllUsers(completion: @escaping([String]?, FetchError?) -> Void) {
        
        Collections.allUsers.collection.getDocuments { (snapShot, error) in

            if let _ = error {
                completion(nil, .backendError)
            } else if let snapShot {
                if snapShot.documents.isEmpty {
                    completion(nil, .noneItem)
                } else {
                    var users: [String] = []
                    for document in snapShot.documents {
                        let data = document.data()
                        let user = data[AllUserTag.uuid] as? String
                        users.append(user!)
                    }
                    completion(users, nil)
                }
            }
        }
    }
}
