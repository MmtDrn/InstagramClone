//
//  PostCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 5.05.2023.
//

import UIKit

class PostCell: BaseCollectionViewCell {
    
    private lazy var imageView: BaseImageView = {
        let imageView = BaseImageView(image: nil,
                                      contentMode: .scaleToFill,
                                      backgroundColor: .clear)
        
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: nil)
        tap.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tap)
    }
    
    override func setupLayout() {
        super.setupLayout()
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func setImage(image: UIImage) {
        self.imageView.image = image
    }
}
