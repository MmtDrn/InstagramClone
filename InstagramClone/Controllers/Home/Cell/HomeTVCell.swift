//
//  HomeTVCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 26.05.2023.
//

import UIKit

protocol HomeTVCellProtocol: AnyObject {
    func setUID(uid: String)
}

class HomeTVCell: BaseTableViewCell {
    
    weak var delegate: HomeTVCellProtocol?
    
    private var model: PostModel? {
        didSet {
            setTopViews()
            setPostView()
            setBottomViews()
        }
    }
    
    private lazy var topView: PostTopView = {
        let view = PostTopView(backGroundColor: .clear)
        
        view.delegate = self
        
        return view
    }()
    
    private lazy var middleView: PostMiddleView = {
        let view = PostMiddleView(backGroundColor: .clear)
        
        view.delegate = self
        
        return view
    }()
    
    private lazy var bottomView: PostBottomView = {
        let view = PostBottomView(backGroundColor: .clear)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .systemGray6
        contentView.addSubview(topView)
        contentView.addSubview(middleView)
        contentView.addSubview(bottomView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(CGFloat.dHeight * (50/812))
        }
        
        middleView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(CGFloat.dHeight * (390/812))
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.bottom)
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    public func setModel(model: PostModel) {
        self.model = model
    }
    
    private func setTopViews() {
        guard let uid = model?.authorUID else { return }
        topView.setViews(uid: uid)
    }
    
    private func setPostView() {
        guard let postURL = model?.postURL else { return }
        middleView.setPostView(postURL: postURL)
    }
    
    private func setBottomViews() {
        if let likeCount = model?.likeCount {
            bottomView.setLikeCount(likeCount: likeCount)
        }
        if let desc = model?.description {
            bottomView.setDescription(description: desc)
        }
    }
    
    public func setCornerRadius() {
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

extension HomeTVCell: PostMiddleViewProtocol, PostTopViewProtocol {
    
    func setUID(uid: String) {
        delegate?.setUID(uid: uid)
    }
        
    func likeAction() {
        print("like")
    }
    
    func commentAction() {
        print("comment")
    }
    
    func directAction() {
        print("direct")
    }
    
    func saveAction() {
        print("save")
    }
}
