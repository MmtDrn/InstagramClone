//
//  HomeVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

enum HomeVMStateChange: StateChange {
    case fetcPostsError(String)
    case fetcPostsSuccess
}


class HomeVM: StatefulVM<HomeVMStateChange> {
    
    let dataSource = HomeDS()
    
    
    func getAllPostData() {
        guard let followed = Defs.shared.userModel?.followingUID else {
            self.emit(.fetcPostsError("You have to follow someone to see the stream on the homepage."))
            return }
        FirebasePostManager.shared.followedPosts(follwedPersons: followed) { [weak self] (models, error) in
            guard let self else { return }
            if let error {
                self.emit(.fetcPostsError(error.message))
            } else {
                guard let models else { return }
                self.dataSource.models = models
                self.emit(.fetcPostsSuccess)
            }
        }
    }
}
