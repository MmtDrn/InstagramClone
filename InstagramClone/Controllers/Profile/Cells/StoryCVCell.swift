//
//  StoryCVCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 5.06.2023.
//

import UIKit

class StoryCVCell: BaseCollectionViewCell {
        
    private lazy var postImageView: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "pf"),
                                      contentMode: .scaleAspectFill,
                                      backgroundColor: .clear)
        
        imageView.layer.cornerRadius = CGFloat.dHeight * (25/812)
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var tagLabel: BaseLabel = {
        let label = BaseLabel(text: "summer",
                              textColor: .black,
                              textAlignment: .center,
                              numberOfLines: 1,
                              font: .systemFont(ofSize: CGFloat.dHeight * (10/812), weight: .regular),
                              backGroundColor: .clear)
        
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubview(postImageView)
        contentView.addSubview(tagLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        postImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(4)
            make.height.width.equalTo(60)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(postImageView.snp.bottom).offset(4)
        }
    }
}
