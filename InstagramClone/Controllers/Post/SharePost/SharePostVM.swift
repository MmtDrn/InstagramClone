//
//  SharePostVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 16.05.2023.
//

import UIKit
import Firebase
import ProgressHUD
import FirebaseFirestore

enum SharePostVMStateChange: StateChange {
    case shareSuccessful
    case showAlert(String)
}

class SharePostVM: StatefulVM<SharePostVMStateChange> {
    
    private let postManager: PostManagerProtocol
    
    init(postManager: PostManagerProtocol) {
        self.postManager = postManager
    }
    
    public func sharePost(image: UIImage, description: String?) {
        postManager.shareImage(shareType: .post, image: image, description: description) { [weak self] result in
            guard let self else { return }
            switch result {
                
            case .success(_):
                self.emit(.shareSuccessful)
            case .failure(let error):
                self.emit(.showAlert(error.localizedDescription))
            }
        }
    }
}
