//
//  PostButtonsView.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit

protocol PostButtonsProtocol: AnyObject {
    func cameraTapped()
    func libraryTapped()
}

class PostButtonsView: BaseView {
    
    weak var delegate: PostButtonsProtocol?
    var showing: Bool = true {
        didSet {
            showHide()
        }
    }
    
    private lazy var cameraButton: BaseButton = {
        let button = BaseButton(image: UIImage(systemName: "camera.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                                cornerRadius: CGFloat.dHeight * (25/812),
                                backGroundColor: .orange)
        
        button.addTarget(self, action: #selector(cameraTapped), for: .touchUpInside)

        return button
    }()
    
    private lazy var libraryButton: BaseButton = {
        let button = BaseButton(image: UIImage(systemName: "photo.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                                cornerRadius: CGFloat.dHeight * (25/812),
                                backGroundColor: .orange)
        
        button.addTarget(self, action: #selector(libraryTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var buttonsStackView: BaseStackView = {
        let stackView = BaseStackView(arrangedSubviews: [cameraButton, libraryButton],
                                      axis: .horizontal,
                                      alignment: .fill,
                                      distribution: .fillEqually,
                                      spacing: 10)
        
        
        
        return stackView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(buttonsStackView)
        backgroundColor = .clear
        self.cameraButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.libraryButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        buttonsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func cameraTapped() {
        delegate?.cameraTapped()
    }
    
    @objc private func libraryTapped() {
        delegate?.libraryTapped()
    }
    
    private func showHide() {
        
        UIView.animate(withDuration: 0.25) {
            if self.showing {
                self.cameraButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.libraryButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.isHidden = true

                }
            } else {
                self.isHidden = false
                self.cameraButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.libraryButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            }
        }
        
        
    }
}
