//
//  StoryCVCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 5.06.2023.
//

import UIKit

class StoryCVCell: BaseCollectionViewCell {
    
    private lazy var postBackView: BaseView = {
        let view = BaseView()
        view.layer.cornerRadius = CGFloat.dHeight * (25/812)
        view.clipsToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.withHex("C128BF").cgColor,
                                UIColor.withHex("EA4C45").cgColor,
                                UIColor.withHex("F8D247").cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        return view
    }()
        
    private lazy var postImageView: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "pf"),
                                      contentMode: .scaleAspectFill,
                                      backgroundColor: .clear)
        
        imageView.layer.cornerRadius = CGFloat.dHeight * (25/812)
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.isHidden = false
        
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
        
        contentView.addSubview(postBackView)
        postBackView.addSubview(postImageView)
        contentView.addSubview(tagLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        postBackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(4)
            make.height.width.equalTo(60)
        }
        
        postImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(57)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(postImageView.snp.bottom).offset(4)
        }
    }
}
