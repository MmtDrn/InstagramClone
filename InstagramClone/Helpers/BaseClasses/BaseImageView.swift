//
//  BaseImageView.swift
//  InstagramClone
//
//  Created by mehmet duran on 5.05.2023.
//

import UIKit

class BaseImageView: UIImageView {
    
    init(image: UIImage?,
         contentMode: UIView.ContentMode,
         backgroundColor: UIColor? = .clear) {
        
        super.init(image: image)
        self.contentMode = contentMode
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
