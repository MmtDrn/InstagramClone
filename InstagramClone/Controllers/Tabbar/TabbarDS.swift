//
//  TabbarDS.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit

enum TabbarDSStateChange: StateChange {
    case setImage(UIImage)
}

class TabbarDS: StatefulDS<TabbarDSStateChange> {
    
}

extension TabbarDS: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            emit(.setImage(image))
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
