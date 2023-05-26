//
//  BaseTextView.swift
//  InstagramClone
//
//  Created by mehmet duran on 24.05.2023.
//

import UIKit

class BaseTextView: UITextView {
    
    convenience init(text: TextType,
                     font: UIFont? = nil,
                     textColor: UIColor? = .black,
                     isEditable: Bool = true,
                     allowsEditingTextAttributes: Bool = false,
                     textAlignment: NSTextAlignment = .natural,
                     textContainerInset: UIEdgeInsets = .zero,
                     backgroundColor: UIColor? = .white,
                     tintColor: UIColor? = .black,
                     showVerticalScrollIndicator: Bool? = false) {
        
        self.init()
        
        switch text {
            case .plain(let string):
                self.text = string
            case .attributed(let string):
                self.attributedText = string
            case .empty:
                self.attributedText = nil
                self.text = nil
        }
        
        if let aFont = font {
            self.font = aFont
        }
        
        self.textColor = textColor
        self.isEditable = isEditable
        self.allowsEditingTextAttributes = allowsEditingTextAttributes
        self.textAlignment = textAlignment
        self.textContainerInset = textContainerInset
        self.backgroundColor = backgroundColor
        self.showsVerticalScrollIndicator = showVerticalScrollIndicator!
        
        if let color = tintColor {
            self.tintColor = color
        }
    }
}
