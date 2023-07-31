//
//  Routers.swift
//  InstagramClone
//
//  Created by mehmet duran on 31.07.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

enum DocumentMethod {
    case get
    case add
}

protocol SnapShotConfiguration {
    var collection: CollectionReference { get }
    var method: DocumentMethod { get }
    var data: [String : Any]? { get }
}

extension SnapShotConfiguration {
    
    func asSnapShot1() async throws  -> QuerySnapshot {
        do {
            return try await collection.getDocuments()
        } catch {
            throw error
        }
    }

    
    func asSnapShot(completion: @escaping(QuerySnapshot?, Error?) -> Void) {
        collection.getDocuments { snapShot, error in
            if let error {
                completion(nil, error)
            } else {
                completion(snapShot, nil)
            }
        }
    }
}



enum Routers: SnapShotConfiguration {
    case getPost(uuid: String)
    
    var collection: CollectionReference {
        switch self {
        case .getPost(let uuid):
            return Collections.postData(uid: uuid).collection
        }
    }
    
    var method: DocumentMethod {
        switch self {
        case .getPost:
            return .get
        }
    }
    
    var data: [String : Any]? {
        switch self {
        case .getPost:
            return nil
        }
    }
    
    
    
}
