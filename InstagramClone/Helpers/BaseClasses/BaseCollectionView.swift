//
//  BaseCollectionView.swift
//  InstagramClone
//
//  Created by mehmet duran on 29.04.2023.
//

import UIKit

class BaseCollectionView: UICollectionView {
    
    convenience init(layout: UICollectionViewLayout,
                     cells: [UICollectionViewCell.Type],
                     allowsSelection: Bool = true,
                     allowsMultipleSelection: Bool = false,
                     isPagingEnabled: Bool = false,
                     showsVerticalScrollIndicator: Bool = true,
                     showsHorizontalScrollIndicator: Bool = true,
                     scrollIndicatorInsets: UIEdgeInsets = .zero,
                     bounces: Bool = true,
                     backgroundColor: UIColor? = .white) {
        self.init(frame: .zero, collectionViewLayout: layout)
        
        for cell in cells {
            register(cell, forCellWithReuseIdentifier: cell.identifier)
        }
            
        self.allowsSelection = allowsSelection
        self.allowsMultipleSelection = allowsMultipleSelection
        self.isPagingEnabled = isPagingEnabled
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        self.scrollIndicatorInsets = scrollIndicatorInsets
        self.bounces = bounces
        self.backgroundColor = backgroundColor
    }
}
