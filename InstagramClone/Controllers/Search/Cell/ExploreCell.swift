//
//  ExploreCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 11.07.2023.
//

import UIKit
import Kingfisher

protocol ExploreCellProtocol: AnyObject {
    func clickPost(cell: BaseCollectionViewCell)
}

class ExploreCell: BaseCollectionViewCell {
    
    weak var delegate: ExploreCellProtocol?
    
    private lazy var imageview: BaseImageView = {
        let imageView = BaseImageView(image: nil,
                                      contentMode: .scaleToFill,
                                      backgroundColor: .clear)
        
        imageView.layer.cornerRadius = CGFloat.dHeight * (10/812)
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(clickPost)))
        
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(imageview)
    }
    
    override func setupLayout() {
        super.setupLayout()
        imageview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func clickPost() {
        delegate?.clickPost(cell: self)
    }
    
    public func setView(model: PostModel) {
        guard let urlString = model.postURL,
              let url = URL(string: urlString) else { return }
        imageview.kf.setImage(with: url)
    }
}
