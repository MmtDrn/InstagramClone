//
//  SocialLoginButton.swift
//  InstagramClone
//
//  Created by mehmet duran on 31.03.2023.
//

import UIKit

class SocialLoginButton: UIButton {
    
    private lazy var socialIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    private lazy var socialTitleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(socialIcon)
        addSubview(socialTitleLabel)
        
        socialIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.dHeight * (8/812))
            make.height.width.equalTo(CGFloat.dHeight * (20/812))
        }
        
        socialTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(socialIcon.snp.trailing).offset(CGFloat.dHeight * (4/812))
            make.centerY.equalToSuperview()
        }
    }
    
    convenience init(image: UIImage? = nil,
                     title: String? = nil) {
        self.init()
        
        self.socialIcon.image = image
        self.socialTitleLabel.text = title
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = CGFloat.dHeight * (10/812)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
