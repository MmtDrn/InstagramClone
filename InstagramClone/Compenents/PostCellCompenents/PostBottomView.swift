//
//  PostBottomView.swift
//  InstagramClone
//
//  Created by mehmet duran on 26.05.2023.
//

import UIKit

class PostBottomView: BaseView {
    
    private lazy var likeCountLabel: BaseLabel = {
        let label = BaseLabel(text: "\(Int.random(in: 101...199)) likes",
                              textColor: .black,
                              textAlignment: .left,
                              numberOfLines: 1,
                              font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold))
        return label
    }()
    
    private lazy var descriptionLabel: BaseLabel = {
        let label = BaseLabel(text: "",
                              textColor: .black,
                              textAlignment: .left,
                              numberOfLines: 2,
                              font: .systemFont(ofSize: CGFloat.dHeight * (12/812), weight: .regular))
        return label
    }()
    
    private lazy var commentLabel: BaseLabel = {
        let label = BaseLabel(text: "See all \(Int.random(in: 37...99)) comments",
                              textColor: .gray,
                              textAlignment: .left,
                              numberOfLines: 1,
                              font: .systemFont(ofSize: CGFloat.dHeight * (12/812), weight: .light))
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(likeCountLabel)
        addSubview(descriptionLabel)
        addSubview(commentLabel)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        likeCountLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(likeCountLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
        }
    }
    
    public func setLikeCount(likeCount: String) {
        likeCountLabel.text = "\(likeCount) likes"
    }
    
    public func setDescription(description: String) {
        descriptionLabel.text = description
    }
}
