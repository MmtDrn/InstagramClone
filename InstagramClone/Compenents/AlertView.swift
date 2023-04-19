//
//  AlertView.swift
//  InstagramClone
//
//  Created by mehmet duran on 4.04.2023.
//

import UIKit

class AlertView: BaseView {
    
    private lazy var titleLabel: BaseLabel = {
       let label = BaseLabel(text: "There is an error",
                             textColor: .black,
                             textAlignment: .center,
                             numberOfLines: .zero,
                             font: .systemFont(ofSize: 16, weight: .semibold),
                             backGroundColor: .clear)
        return label
    }()
    
    private lazy var messageLabel: BaseLabel = {
       let label = BaseLabel(text: "Please check your email input!",
                             textColor: .black,
                             textAlignment: .center,
                             numberOfLines: .zero,
                             font: .systemFont(ofSize: 14, weight: .regular),
                             backGroundColor: .clear)
        return label
    }()
    
    private lazy var stackView: BaseStackView = {
        var stackView = BaseStackView(arrangedSubviews: [titleLabel, messageLabel],
                                      axis: .vertical,
                                      alignment: .fill,
                                      distribution: .fill,
                                      spacing: 10)
        return stackView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        
        addSubview(stackView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        stackView.snp.updateConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    public func setMessage(message: String) {
        self.messageLabel.text = message
    }
}
