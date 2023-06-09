//
//  BaseLabel.swift
//  InstagramClone
//
//  Created by mehmet duran on 3.04.2023.
//

import UIKit

class BaseLabel: UILabel {
    
    convenience init(text: String? = nil,
                     textColor: UIColor? = .black,
                     textAlignment: NSTextAlignment = .center,
                     numberOfLines: Int = .zero,
                     font: UIFont? = nil,
                     backGroundColor: UIColor? = .clear) {
        self.init()
        
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.font = font
        self.backgroundColor = backGroundColor
        self.adjustsFontSizeToFitWidth = false
    }
}
