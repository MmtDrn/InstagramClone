//
//  ProfilePostCVCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 5.06.2023.
//

import UIKit
import Kingfisher

class ProfilePostCVCell: BaseCollectionViewCell {
    
    private lazy var postImageView: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "pf"),
                                      contentMode: .scaleAspectFill,
                                      backgroundColor: .clear)
        
        imageView.layer.cornerRadius = CGFloat.dHeight * (25/812)
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubview(postImageView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        postImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func setView(model: PostModel) {
        guard let postURL = model.postURL else { return }
        let url =  URL(string: postURL)
        
        postImageView.kf.indicatorType = .activity
        postImageView.kf.setImage(
            with: url,
            placeholder: UIImage(),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
