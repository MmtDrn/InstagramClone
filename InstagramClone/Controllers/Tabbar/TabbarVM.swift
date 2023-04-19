//
//  TabbarVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit
import Firebase
import ProgressHUD

enum TabbarVMStateChange: StateChange {
    case showAlert(message: String)
    case mediaUploadSuccessfully(pickerController: UIImagePickerController)
}

class TabbarVM: StatefulVM<TabbarVMStateChange> {
    
    var dataSource = TabbarDS()
    var pickerController: UIImagePickerController?
    
    public func cameraButtonTapped() {
        pickerController = UIImagePickerController()
        
        pickerController!.delegate = dataSource
        pickerController!.sourceType = .camera
        pickerController!.modalPresentationStyle = .fullScreen
        
        UIApplication.getTopViewController()?.present(pickerController!, animated: true)
    }
    
    public func libraryButtonTapped() {
        pickerController = UIImagePickerController()
        
        pickerController!.delegate = dataSource
        pickerController!.sourceType = .photoLibrary
        pickerController!.modalPresentationStyle = .fullScreen
        pickerController!.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(self.dataSource.imagePickerController(_:didFinishPickingMediaWithInfo:)))
        UIApplication.getTopViewController()?.present(pickerController!, animated: true)
    }
    
    public func setImageToStorage(image: UIImage) {
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.show("Loading", interaction: true)
        pickerController?.view.isUserInteractionEnabled = false
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            let imageReferance = mediaFolder.child("image.jpg")
            
            imageReferance.putData(imageData) { [weak self] (metaData, error) in
                guard let self = self else { return }
                if error != nil {
                    self.emit(.showAlert(message: error?.localizedDescription ?? ""))
                } else {
                    ProgressHUD.dismiss()
                    self.emit(.mediaUploadSuccessfully(pickerController: self.pickerController!))
                }
            }
        }
    }
}
