//
//  TabbarVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit
import Firebase
import Photos

enum TabbarVMStateChange: StateChange {
    case pushPostVC
    case showAlert(alertVC: UIAlertController)
}

class TabbarVM: StatefulVM<TabbarVMStateChange> {
    
    var dataSource = TabbarDS()
    
    public func cameraButtonTapped() {
        let pickerController = UIImagePickerController()
        
        pickerController.sourceType = .camera
        pickerController.modalPresentationStyle = .fullScreen
        
        UIApplication.getTopViewController()?.present(pickerController, animated: true)
    }
    
    func requestPhotoLibraryAuthorization() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .authorized:
                self.emit(.pushPostVC)
            case .denied, .restricted:
                let alertController = UIAlertController(title: "Photo Library Access Denied", message: "Please grant permission to access your photo library in Settings.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        alertController.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        }))
                self.emit(.showAlert(alertVC: alertController))
            case .notDetermined:
                print("Photo library access not determined.")
            case .limited:
                self.emit(.pushPostVC)
            @unknown default:
                print("Unknown status.")
            }
        }
    }
}
