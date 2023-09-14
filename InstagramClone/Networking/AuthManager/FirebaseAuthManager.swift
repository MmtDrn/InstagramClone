//
//  FirebaseManager.swift
//  InstagramClone
//
//  Created by mehmet duran on 2.06.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

class FirebaseAuthManager: AuthManagerPRotocol {
    
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
                  FirebaseUserDataManager.shared.setUserDataToDB(uid: (result?.user.uid)!,
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
                FirebaseUserDataManager.shared.getUserDatas(uid: result.user.uid) { result in
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
    
    
}
