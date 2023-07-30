//
//  Collections.swift
//  InstagramClone
//
//  Created by mehmet duran on 31.07.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

enum Collections {
    case allPosts
    case allUsers
    case postData(uid: String)
    case users(uid: String)
    
    private var db: Firestore {
        return Firestore.firestore()
    }
    
    var collection: CollectionReference {
        switch self {
        case .allPosts:
            return db.collection("allPosts")
        case .allUsers:
            return db.collection("allUser")
        case .postData(let uid):
            return db.collection("postData").document("\(uid)postData").collection("sharePosts")
        case .users(let uid):
            return db.collection("users").document("\(uid)userData").collection("data")
        }
    }
}
