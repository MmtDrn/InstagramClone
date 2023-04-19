//
//  BaseView.swift
//  InstagramClone
//
//  Created by mehmet duran on 31.03.2023.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayouts()
    }
    
    convenience init(backGroundColor: UIColor) {
        self.init()
        self.backgroundColor = backGroundColor
    }
    
    convenience init(backGroundColor: UIColor,
                     cornerRadius: CGFloat,
                     borderWidth: CGFloat = .zero,
                     borderColor: UIColor = .clear) {
        self.init()
        self.backgroundColor = backGroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc open func setupViews() {}
    @objc open func setupLayouts() {}
}
