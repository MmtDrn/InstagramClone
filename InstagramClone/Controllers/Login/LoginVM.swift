//
//  LoginVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit
import Firebase

enum LoginVMStateChange: StateChange {
    case showAlert(message: String)
    case logInSucces
}

class LoginVM: StatefulVM<LoginVMStateChange> {
    
    func logİn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.emit(.showAlert(message: error?.localizedDescription ?? ""))
            } else {
                guard let result = result else { return }
                self.getUserData(uid: result.user.uid)
                self.emit(.logInSucces)
            }
        }
    }
    
    private func getUserData(uid: String) {
        
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
                        
                        Defs.shared.userModel = DefsUserModel(uid: uuid,
                                                              fullName: fullName,
                                                              userName: userName,
                                                              email: email,
                                                              phoneNumber: phoneNumber)
                    }
                    
                    if let profilImageURL = data["profilImageURL"] as? String {
                        self.updateProfilImageURL(profilImageURL: profilImageURL)
                        Defs.shared.userModel?.profilImageURL = profilImageURL
                    }
                    
                    if let followers = data["followerUID"] as? [String] {
                        self.updateFollowers(followers: followers)
                        Defs.shared.userModel?.followers = followers
                    }
                    
                    if let following = data["followingUID"] as? [String] {
                        self.updateFollowing(following: following)
                        Defs.shared.userModel?.following = following
                    }
                }
            }
        }
    }
    
    func updateProfilImageURL(profilImageURL: String) {
        let db = Firestore.firestore()
        
        db.collection("users").document("\(Defs.shared.userModel?.uid ?? "")userData").collection("data").getDocuments { (snapShot, error) in
            if error == nil {
                snapShot?.documents.first?.reference.setData(["profilImageURL": profilImageURL], merge: true)
//                for document in snapShot!.documents {
//                    document.reference.setData(["profilImageURL": "profilImageURL"], merge: true)
//                }
            }
        }
    }
    
    func updateFollowers(followers: [String]) {
        let db = Firestore.firestore()
        
        db.collection("users").document("\(Defs.shared.userModel?.uid ?? "")userData").collection("data").getDocuments { (snapShot, error) in
            if error == nil {
                snapShot?.documents.first?.reference.setData(["followers": followers], merge: true)
//                for document in snapShot!.documents {
//                    document.reference.setData(["profilImageURL": "profilImageURL"], merge: true)
//                }
            }
        }
    }
    
    func updateFollowing(following: [String]) {
        let db = Firestore.firestore()
        
        db.collection("users").document("\(Defs.shared.userModel?.uid ?? "")userData").collection("data").getDocuments { (snapShot, error) in
            if error == nil {
                snapShot?.documents.first?.reference.setData(["following": following], merge: true)
//                for document in snapShot!.documents {
//                    document.reference.setData(["profilImageURL": "profilImageURL"], merge: true)
//                }
            }
        }
    }
}
