//
//  PostHeaderView.swift
//  InstagramClone
//
//  Created by mehmet duran on 26.05.2023.
//

import UIKit

class PostTopView: BaseView {
    
    private lazy var profilImage: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "pf"),
                                      contentMode: .scaleAspectFill,
                                      backgroundColor: .clear)
        
        imageView.layer.cornerRadius = CGFloat.dHeight * (20/812)
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var nameLabel: BaseLabel = {
        let label = BaseLabel(text: "mehmet.durann",
                              textColor: .black,
                              textAlignment: .left,
                              numberOfLines: 0,
                              font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                              backGroundColor: .clear)
        
        return label
    }()
    
    private lazy var threeTopPointImage: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "threeTopPoint"),
                                      contentMode: .scaleAspectFit,
                                      backgroundColor: .clear)
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(profilImage)
        addSubview(nameLabel)
        addSubview(threeTopPointImage)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        profilImage.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.dHeight * (40/812))
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profilImage.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
        }
        
        threeTopPointImage.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.dHeight * (40/812))
            make.width.equalTo(CGFloat.dHeight * (20/812))
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
        }
    }
    
    public func setViews(profilImage: UIImage, name: String) {
        self.profilImage.image = profilImage
        self.nameLabel.text = name
    }
}