//
//  PostDS.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit

enum PostDSStateChange: StateChange {
    case setImage(image: UIImage)
    case cancel
}

class PostDS: StatefulDS<PostDSStateChange> {
    
}

extension PostDS: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            emit(.setImage(image: image))
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        emit(.cancel)
    }
}
