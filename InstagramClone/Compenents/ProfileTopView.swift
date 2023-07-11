//
//  ProfileTopView.swift
//  InstagramClone
//
//  Created by mehmet duran on 4.06.2023.
//

import UIKit
import Kingfisher

protocol ProfileTopViewProtocol: AnyObject {
    func clickFollowers()
    func clickFollowing()
    func clickImage()
    func clickFallowButton()
    func clickMessageButton()
}

class ProfileTopView: BaseView {
    
    weak var delegate: ProfileTopViewProtocol?
    private var profilType: ProfilType = .oneself
    
    private lazy var profilImageView: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "noneUserPlus"),
                                      contentMode: .scaleAspectFill,
                                      backgroundColor: .clear)
        
        imageView.layer.cornerRadius = CGFloat.dHeight * (50/812)
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickViews(sender:))))

        return imageView
    }()
    
    private lazy var nameLabel: BaseLabel = {
        let label = BaseLabel(text: Defs.shared.userModel?.fullName,
                              textColor: .black,
                              textAlignment: .center,
                              numberOfLines: 0,
                              font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .regular),
                              backGroundColor: .clear)
        
        return label
    }()
    
    private lazy var postLabel: BaseLabel = {
        let label = BaseLabel(text: nil,
                              textColor: .black,
                              textAlignment: .center,
                              numberOfLines: 0,
                              font: .systemFont(ofSize: CGFloat.dHeight * (18/812), weight: .semibold),
                              backGroundColor: .clear)
        return label
    }()
    
    private lazy var followersLabel: BaseLabel = {
        let label = BaseLabel(text: nil,
                              textColor: .black,
                              textAlignment: .center,
                              numberOfLines: 0,
                              font: .systemFont(ofSize: CGFloat.dHeight * (18/812), weight: .semibold),
                              backGroundColor: .clear)
        
        label.tag = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickViews(sender:))))
        
        return label
    }()
    
    private lazy var followingLabel: BaseLabel = {
        let label = BaseLabel(text: nil,
                              textColor: .black,
                              textAlignment: .center,
                              numberOfLines: 0,
                              font: .systemFont(ofSize: CGFloat.dHeight * (18/812), weight: .semibold),
                              backGroundColor: .clear)
        
        label.tag = 1
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickViews(sender:))))
        
        return label
    }()
    
    private lazy var stackViewLabels: BaseStackView = {
        let stackView = BaseStackView(arrangedSubviews: [postLabel, followersLabel, followingLabel],
                                      axis: .horizontal,
                                      alignment: .fill,
                                      distribution: .fillEqually,
                                      spacing: 0)
        return stackView
    }()
    
    private lazy var followButton: BaseButton = {
        let button = BaseButton(title: "Follow",
                                titleColor: .white,
                                titleFont: .systemFont(ofSize: CGFloat.dHeight * (15/812), weight: .semibold),
                                borderWidth: 0.5,
                                borderColor: .gray,
                                cornerRadius: CGFloat.dHeight * (10/812),
                                backGroundColor: .systemBlue)
        
        button.layer.opacity = 0.8
        button.tag = 0
        button.addTarget(self, action: #selector(clickButtons(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var messageButton: BaseButton = {
        let button = BaseButton(title: "Message",
                                titleColor: .black,
                                titleFont: .systemFont(ofSize: CGFloat.dHeight * (15/812), weight: .medium),
                                borderWidth: 0.5,
                                borderColor: .gray,
                                cornerRadius: CGFloat.dHeight * (10/812),
                                backGroundColor: .white)
        
        button.tag = 1
        button.addTarget(self, action: #selector(clickButtons(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var stackViewbuttons: BaseStackView = {
        let stackView = BaseStackView(arrangedSubviews: [followButton, messageButton],
                                      axis: .horizontal,
                                      alignment: .fill,
                                      distribution: .fillEqually,
                                      spacing: 10)
        stackView.isHidden = true
        
        return stackView
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .systemGray6
        addSubview(profilImageView)
        addSubview(nameLabel)
        addSubview(stackViewLabels)
        addSubview(stackViewbuttons)
        
        setViews()
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        profilImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(CGFloat.dHeight * (100/812))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profilImageView.snp.bottom).offset(8)
        }
        
        stackViewLabels.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.dHeight * (20/812))
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
        }
        
        stackViewbuttons.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.dHeight * (60/812))
            make.top.equalTo(stackViewLabels.snp.bottom).offset(20)
        }
    }
    
    @objc private func clickViews(sender: UITapGestureRecognizer) {
        if let label = sender.view as? UILabel {
            switch label.tag {
            case 0:
                delegate?.clickFollowers()
            case 1:
                delegate?.clickFollowing()
            default: break
            }
        } else if let _ = sender.view as? UIImageView {
            if profilType == .oneself {
                delegate?.clickImage()
            }
        }
    }
    
    @objc private func clickButtons(sender: BaseButton) {
        switch sender.tag {
        case 0:
            delegate?.clickFallowButton()
        case 1:
            delegate?.clickMessageButton()
        default: break
        }
    }
    
    public func setPostCountPF(count: Int, profilType: ProfilType) {
        self.profilType = profilType
        let postLabelText = "\(count)\nPosts"
        let postLabelAttributedString = NSMutableAttributedString(string: postLabelText)
        let lastFiveRange = NSRange(location: postLabelText.count - 5, length: 5)
        let lastFont = UIFont.systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .light)
        let lastColor = UIColor.black
        postLabelAttributedString.addAttribute(.font, value: lastFont, range: lastFiveRange)
        postLabelAttributedString.addAttribute(.foregroundColor, value: lastColor, range: lastFiveRange)
        postLabel.attributedText = postLabelAttributedString
        
        
        switch profilType {
        case .oneself:
            guard let pfImageString = Defs.shared.userModel?.profilImageURL,
                  let url = URL(string: pfImageString) else { return }
            profilImageView.kf.setImage(with: url)
        case .anyone(let uid):
            stackViewbuttons.isHidden = false
            FirebaseAuthManager.shared.getUserdata(userDataType: .profilImageUrl, uid: uid) { [weak self] (data: String?, error) in
                guard let self else { return }
                if let _ = error {
                    self.profilImageView.image = UIImage(named: "noneUser")
                } else {
                    guard let pfImageString = data,
                          let url = URL(string: pfImageString) else { return }
                    self.profilImageView.kf.setImage(with: url)
                }
            }
            
            FirebaseAuthManager.shared.getUserdata(userDataType: .fullName, uid: uid) { [weak self] (data:String?, error) in
                guard let data else { return }
                self?.nameLabel.text = data
            }
        }
        
        
    }
    
    private func setViews() {
        
        nameLabel.text = Defs.shared.userModel?.fullName
        
        let lastFont = UIFont.systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .light)
        let lastColor = UIColor.black
        let followersLabelText = "\(Defs.shared.userModel?.followerUID?.count ?? 0)\nFollowers"
        let followersLabelAttributedString = NSMutableAttributedString(string: followersLabelText)
        let lastNineRange = NSRange(location: followersLabelText.count - 9, length: 9)
        followersLabelAttributedString.addAttribute(.font, value: lastFont, range: lastNineRange)
        followersLabelAttributedString.addAttribute(.foregroundColor, value: lastColor, range: lastNineRange)
        followersLabel.attributedText = followersLabelAttributedString
        
        let followingLabelText = "\(Defs.shared.userModel?.followingUID?.count ?? 0)\nFollowing"
        let followingLabelAttributedString = NSMutableAttributedString(string: followingLabelText)
        let lastNine1Range = NSRange(location: followingLabelText.count - 9, length: 9)
        followingLabelAttributedString.addAttribute(.font, value: lastFont, range: lastNine1Range)
        followingLabelAttributedString.addAttribute(.foregroundColor, value: lastColor, range: lastNine1Range)
        followingLabel.attributedText = followingLabelAttributedString
        }
}