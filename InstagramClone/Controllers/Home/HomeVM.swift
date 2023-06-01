//
//  HomeVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit
import Firebase

enum HomeVMStateChange: StateChange {
    
}


class HomeVM: StatefulVM<HomeVMStateChange> {
    
    let dataSource = HomeDS()
    
    public func getDataFromDB() {
        let db = Firestore.firestore()
        
        db.collection("postData").document("11postData").collection("sharePosts").addSnapshotListener { [weak self] (snapShot, error) in
            if let error {
                print(error.localizedDescription)
            }
            
            for document in snapShot!.documents {
                print(document.documentID)
            }
        }
    }
}
