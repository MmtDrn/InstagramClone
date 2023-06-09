//
//  PostMiddleView.swift
//  InstagramClone
//
//  Created by mehmet duran on 26.05.2023.
//

import UIKit
import Kingfisher

protocol PostMiddleViewProtocol: AnyObject {
    func likeAction()
    func commentAction()
    func directAction()
    func saveAction()
}

class PostMiddleView: BaseView {
    
    private lazy var itemSize = CGFloat.dHeight * (25/812)
    weak var delegate: PostMiddleViewProtocol?
    
    private lazy var postImage: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(),
                                      contentMode: .scaleToFill,
                                      backgroundColor: .clear)
        
        imageView.layer.cornerRadius = CGFloat.dHeight * (20/812)
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var likeImage: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "heart"),
                                      contentMode: .scaleAspectFill,
                                      backgroundColor: .clear)
        
        imageView.tag = 0
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageAction(sender:))))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private lazy var commentImage: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "commentBubble"),
                                      contentMode: .scaleAspectFill,
                                      backgroundColor: .clear)
        
        imageView.tag = 1
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageAction(sender:))))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private lazy var directImage: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "direct"),
                                      contentMode: .scaleAspectFill,
                                      backgroundColor: .clear)
        
        imageView.tag = 2
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageAction(sender:))))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private lazy var saveImage: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "bookmark"),
                                      contentMode: .scaleAspectFill,
                                      backgroundColor: .clear)
        
        imageView.tag = 3
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageAction(sender:))))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(postImage)
        addSubview(likeImage)
        addSubview(commentImage)
        addSubview(directImage)
        addSubview(saveImage)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        postImage.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * (350/812))
        }
        
        likeImage.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.width.height.equalTo(itemSize)
        }
        
        commentImage.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(8)
            make.leading.equalTo(likeImage.snp.trailing).offset(12)
            make.width.height.equalTo(itemSize)
        }
        
        directImage.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(8)
            make.leading.equalTo(commentImage.snp.trailing).offset(12)
            make.width.height.equalTo(itemSize)
        }
        
        saveImage.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(10)
            make.height.width.equalTo(itemSize)
        }
    }
    
    @objc private func imageAction(sender: UITapGestureRecognizer) {
        guard let image = sender.view as? BaseImageView else { return }
        let tag = image.tag
        switch tag {
        case 0:
            delegate?.likeAction()
        case 1:
            delegate?.commentAction()
        case 2:
            delegate?.directAction()
        case 3:
            delegate?.saveAction()
        default:
            break
        }
    }
    
    public func setPostView(postURL: String) {
        guard let url = URL(string: postURL) else { return }
        postImage.kf.setImage(with: url)
    }
}
