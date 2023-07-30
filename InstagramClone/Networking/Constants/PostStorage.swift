//
//  PostStorage.swift
//  InstagramClone
//
//  Created by mehmet duran on 31.07.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

enum PostStorage {
    
    case post(uid: String)
    
    var imageReferance: StorageReference {
        switch self {
        case .post(let uid):
            return Storage.storage().reference().child("posts").child("\(uid).jpg")
        }
    }
}
