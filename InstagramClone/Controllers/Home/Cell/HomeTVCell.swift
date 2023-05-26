//
//  HomeTVCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 26.05.2023.
//

import UIKit

class HomeTVCell: BaseTableViewCell {
    
    private lazy var topView: PostTopView = {
        let view = PostTopView(backGroundColor: .clear)
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
        backgroundColor = .clear
        contentView.addSubview(topView)
        contentView.addSubview(middleView)
        contentView.addSubview(bottomView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        topView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * (50/812))
        }
        
        middleView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * (340/812))
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.bottom)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
    }
}

extension HomeTVCell: PostMiddleViewProtocol {
    
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
