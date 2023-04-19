//
//  PostVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit

enum PostCases: Int {
    case post
    case upload
}

enum PostVMStateChange: StateChange {
    
}

class PostVM: StatefulVM<PostVMStateChange> {
    
    var dataSource = PostDS()
    var step = 0
    
    public func choseImage() {
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = dataSource
        pickerController.sourceType = .photoLibrary
        pickerController.modalPresentationStyle = .fullScreen
        
        UIApplication.getTopViewController()?.present(pickerController, animated: true)
    }
}

