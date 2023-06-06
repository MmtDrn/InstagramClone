//
//  PostVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit
import Photos

enum ChoosePostVMStateChange: StateChange {
    case relodData
    case setPFSuccess
}

class ChoosePostVM: StatefulVM<ChoosePostVMStateChange> {
    
    var dataSource = ChoosePostDS()
    var shareType: ShareType?
    
    func fetchImages() {
        let fetchOptions = PHFetchOptions()
        
        fetchOptions.fetchLimit = .max
        let images = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        images.enumerateObjects { [weak self] asset, count, _ in
            guard let self = self, let image = asset.convertToUIImage() else { return }
            self.dataSource.images.append(image)
        }
        self.emit(.relodData)
    }
    
    func setProfilImage(image: UIImage) {
        FirebasePostManager.shared.shareImage(shareType: .profilImage,
                                              image: image, description: nil) { [weak self] result in
            guard let self else { return }
            switch result {
                
            case .success(_):
                self.emit(.setPFSuccess)
            case .failure(_):
                self.emit(.setPFSuccess)
            }
        }
    }
}

