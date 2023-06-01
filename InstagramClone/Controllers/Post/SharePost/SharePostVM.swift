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
}

class SharePostVM: StatefulVM<SharePostVMStateChange> {
    
    public func sharePost(image: UIImage, description: String) {
        UIApplication.getTopViewController()?.view.isUserInteractionEnabled = false
        UIApplication.getTopViewController()?.navigationController?.navigationBar.isUserInteractionEnabled = false
        ProgressHUD.show()
        
        let storageReferance = Storage.storage().reference()
        let mediaFolder = storageReferance.child("posts")
        
        if let data = image.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data) { [weak self] (metadata, error) in
                guard let self else { return }
                if let error = error {
                    AlertManager.shared.showAlert(onVC: UIApplication.getTopViewController(), type: .justMessage(message: error.localizedDescription))
                } else {
                    ProgressHUD.dismiss()
                    imageReferance.downloadURL { (url, error) in
                        guard let url else { return }
                        self.setPostData(postURL: url.absoluteString, description: description, likeCount: nil)
                    }
                    self.emit(.shareSuccessful)
                }
            }
        }
    }
    
    public func popToTabbarvc(on: BaseViewController) {
        on.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setPostData(postURL: String,
                             description: String?,
                             likeCount: String?) {
        
        let data: [String : Any] = ["postURL": postURL, "description" : description, "likeCount" : likeCount, "date" : Date().stringValue()]
        
        let fireStoreDatabase = Firestore.firestore()
        var fireStoreReferance : DocumentReference? = nil
        
        fireStoreReferance = fireStoreDatabase.collection("postData").document("11postData").collection("sharePosts").addDocument(data: data, completion: { [weak self] error in
            guard let self else { return }
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("*******************/npost data save succesfly/n*******************")
            }
        })
            
            
//            .addDocument(data: data, completion: { [weak self] error in
//            guard let self else { return }
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                print("*******************/npost data save succesfly/n*******************")
//            }
//        })
    }
}
