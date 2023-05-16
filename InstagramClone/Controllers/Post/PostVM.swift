//
//  PostVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit
import Photos

enum PostVMStateChange: StateChange {
    case relodData
}

class PostVM: StatefulVM<PostVMStateChange> {
    
    var dataSource = PostDS()
    
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
}

