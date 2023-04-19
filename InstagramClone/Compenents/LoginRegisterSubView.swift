//
//  LoginRegisterSubView.swift
//  InstagramClone
//
//  Created by mehmet duran on 3.04.2023.
//

import UIKit

class LoginRegisterSubView: BaseView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Don't have an account?"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Sign Up"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var labelStackView: BaseStackView = {
        let stackView = BaseStackView(arrangedSubviews: [titleLabel, subTitleLabel],
                                      axis: .horizontal,
                                      alignment: .fill,
                                      distribution: .fill,
                                      spacing: 2)
        
        
        return stackView
    }()
    
    convenience init(title: String?,
                     subTitle: String?) {
        self.init()
        
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(labelStackView)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        labelStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
