//
//  BaseCollectionViewCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 5.05.2023.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
        setupLayout()
    }
    
    open func setupViews() {
        backgroundColor = .white
    }
    
    open func setupLayout() {}
}
