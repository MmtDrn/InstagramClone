//
//  PostNavView.swift
//  InstagramClone
//
//  Created by mehmet duran on 31.03.2023.
//

import UIKit
import SnapKit

protocol PostNavViewProtocol: AnyObject {
    func navRightButtonAction()
    func navLeftButtonAction()
}

class PostNavView: BaseView {
    
    weak var delegate: PostNavViewProtocol?
    
    private lazy var titleLabel: BaseLabel = {
        let label = BaseLabel(textColor: .black,
                              textAlignment: .center,
                              numberOfLines: .zero,
                              font: .boldSystemFont(ofSize: 18))
        
        return label
    }()
    
    private lazy var leftButton: BaseButton = {
        let button = BaseButton(image: UIImage(named: "xImage"))
        
        button.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var rightButton: BaseButton = {
        let button = BaseButton(image: UIImage(named: "rightArrow"))
        
        button.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    convenience init(title: String) {
        self.init()
        
        backgroundColor = .white
        self.titleLabel.text = title
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        addSubview(rightButton)
        addSubview(leftButton)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(CGFloat.dHeight * (36/812))
            make.height.equalTo(CGFloat.dHeight * (32/812))
        }
        
        leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(CGFloat.dHeight * (36/812))
            make.height.equalTo(CGFloat.dHeight * (32/812))
        }
    }
    
    
    
    @objc private func leftButtonAction() {
        delegate?.navLeftButtonAction()
    }
    
    @objc private func rightButtonAction() {
        delegate?.navRightButtonAction()
    }
}
