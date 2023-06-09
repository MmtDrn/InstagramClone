//
//  ProfilePostCVCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 5.06.2023.
//

import UIKit
import Kingfisher

protocol ProfilePostCVCellProtocol: AnyObject {
    func setIndexPath(cell: BaseCollectionViewCell)
}

class ProfilePostCVCell: BaseCollectionViewCell {
    
    weak var delegate: ProfilePostCVCellProtocol?
    
    private lazy var postImageView: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "pf"),
                                      contentMode: .scaleAspectFill,
                                      backgroundColor: .clear)
        
        imageView.layer.cornerRadius = CGFloat.dHeight * (25/812)
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndexPath)))
        
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
    
    @objc private func setIndexPath() {
        delegate?.setIndexPath(cell: self)
    }
}
