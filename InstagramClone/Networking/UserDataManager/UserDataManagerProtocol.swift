//
//  UserDataManagerProtocol.swift
//  InstagramClone
//
//  Created by mehmet duran on 14.09.2023.
//

import Foundation

protocol UserDataManagerProtocol {
    func setUserDataToDB(uid: String,
                              email: String,
                              fullName: String,
                              userName: String,
                              phoneNumber: String,
                              profilImageURL: String?,
                              followingUID: [String]?,
                              followerUID: [String]?,
                              completion: @escaping(Bool?, RegisterError?) -> Void)
    func getUserDatas(uid: String, completion: @escaping(Result<Bool,Error>)-> Void)
    func updateUserData<T>(userDataType: UserDataType, data: T)
    func getUserdata<T>(userDataType: UserDataType, uid: String, completion: @escaping(T?, FetchError?) -> Void)
    func getAllUsers(completion: @escaping([String]?, FetchError?) -> Void)
}

extension UserDataManagerProtocol {
    func setUserDataToDB(uid: String,
                         email: String,
                         fullName: String,
                         userName: String,
                         phoneNumber: String,
                         profilImageURL: String?,
                         followingUID: [String]?,
                         followerUID: [String]?,
                         completion: @escaping(Bool?, RegisterError?) -> Void) { }
    func getUserDatas(uid: String, completion: @escaping(Result<Bool,Error>)-> Void) { }
    func updateUserData<T>(userDataType: UserDataType, data: T) { }
    func getUserdata<T>(userDataType: UserDataType, uid: String,
                        completion: @escaping(T?, FetchError?) -> Void) { }
    func getAllUsers(completion: @escaping([String]?, FetchError?) -> Void) { }
}
