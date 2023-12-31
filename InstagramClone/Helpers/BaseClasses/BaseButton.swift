//
//  BaseButton.swift
//  InstagramClone
//
//  Created by mehmet duran on 3.04.2023.
//

import UIKit

class BaseButton: UIButton {
    
    lazy var buttonClicked: () -> () = {}
    
    convenience init(title: String? = nil,
                     image: UIImage? = nil,
                     titleColor: UIColor? = .white,
                     titleFont: UIFont? = nil,
                     borderWidth: CGFloat? = 0,
                     borderColor: UIColor? = .clear,
                     cornerRadius: CGFloat? = 0,
                     backGroundColor: UIColor? = .clear,
                     contentVerticalAlignment: UIControl.ContentVerticalAlignment = .center,
                     contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center) {
        self.init()
        
        self.setTitle(title, for: .normal)
        self.setImage(image, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = titleFont
        self.layer.borderWidth = borderWidth!
        self.layer.borderColor = borderColor?.cgColor
        self.layer.cornerRadius = cornerRadius!
        self.backgroundColor = backGroundColor
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.contentHorizontalAlignment = contentHorizontalAlignment
        self.contentVerticalAlignment = contentVerticalAlignment
    }
    
    @objc private func buttonTapped() {
        buttonClicked()
    }
}
