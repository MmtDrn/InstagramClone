//
//  AlertView.swift
//  InstagramClone
//
//  Created by mehmet duran on 4.04.2023.
//

import UIKit

typealias CompletionHandler = (() -> Void)

enum AlertType {
    case justMessage(message: String)
    case doubleButton(message: String, firstButtonTitle: String, secondButtonTitle: String)
}

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
    
    private lazy var stackViewLabels: BaseStackView = {
        var stackView = BaseStackView(arrangedSubviews: [titleLabel, messageLabel],
                                      axis: .vertical,
                                      alignment: .fill,
                                      distribution: .fill,
                                      spacing: 10)
        return stackView
    }()
    
    private lazy var firstButton: BaseButton = {
        let button = BaseButton(title: "Done",
                                titleColor: .white,
                                titleFont: .boldSystemFont(ofSize: 14),
                                borderWidth: 1,
                                borderColor: .black,
                                cornerRadius: CGFloat.dHeight * (12/812),
                                backGroundColor: .black)
        return button
    }()
    
    private lazy var secondButton: BaseButton = {
        let button = BaseButton(title: "Cancel",
                                titleColor: .white,
                                titleFont: .boldSystemFont(ofSize: 14),
                                borderWidth: 1,
                                borderColor: .black,
                                cornerRadius: CGFloat.dHeight * (12/812),
                                backGroundColor: .black)
        return button
    }()
    
    private lazy var stackViewButtons: BaseStackView = {
        var stackView = BaseStackView(arrangedSubviews: [firstButton, secondButton],
                                      axis: .horizontal,
                                      alignment: .center,
                                      distribution: .fillEqually,
                                      spacing: 10)
        return stackView
    }()
    
    init(type: AlertType,
         firstActionCompletion: CompletionHandler? = nil,
         secondActionCompletion: CompletionHandler? = nil) {
        super.init(frame: .zero)
        
        switch type {
        case .justMessage(let message):
            self.messageLabel.text = message
            addSubview(stackViewLabels)
            stackViewLabels.snp.updateConstraints { make in
                make.center.equalToSuperview()
                make.width.equalToSuperview()
            }
            
        case .doubleButton(let message, let firstButtonTitle, let secondButtonTitle):
            
            addSubview(stackViewLabels)
            addSubview(stackViewButtons)
            self.messageLabel.text = message
            
            stackViewLabels.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview()
                make.top.equalToSuperview().offset(CGFloat.dHeight * (40/812))
            }
            
            stackViewButtons.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(5)
                make.height.equalTo(CGFloat.dHeight * (50/812))
                make.bottom.equalToSuperview().inset(10)
            }
            
            self.firstButton.setTitle(firstButtonTitle, for: .normal)
            self.firstButton.buttonClicked = {
                firstActionCompletion?()
            }
            
            self.secondButton.setTitle(secondButtonTitle, for: .normal)
            self.secondButton.buttonClicked = {
                secondActionCompletion?()
            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    override func setupLayouts() {
        super.setupLayouts()
    }
}
