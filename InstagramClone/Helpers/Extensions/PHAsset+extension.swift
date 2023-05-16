//
//  PHAsset+extension.swift
//  InstagramClone
//
//  Created by mehmet duran on 5.05.2023.
//

import UIKit
import Photos

extension PHAsset {
    
    func convertToUIImage() -> UIImage? {
        
        var img: UIImage?
        
        let manager = PHImageManager.default()
        manager.requestImage(for: self,
                             targetSize: .zero,
                             contentMode: .aspectFit,
                             options: nil) { (image, _) in
            img = image
        }
        
        return img
    }
}
