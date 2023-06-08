//
//  ProfileBackView.swift
//  InstagramClone
//
//  Created by mehmet duran on 6.06.2023.
//

import UIKit

class ProfileBackView: BaseView {
    
    private lazy var nonePostLabel: BaseLabel = {
        let label = BaseLabel(text: "You Haven't Shared a Post Yet",
                              textColor: .systemGray3,
                              textAlignment: .center,
                              numberOfLines: .zero,
                              font: .boldSystemFont(ofSize: CGFloat.dHeight * (25/812)),
                              backGroundColor: .clear)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(nonePostLabel)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        nonePostLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    public func setLabelHiddenStatus() {
        nonePostLabel.isHidden = true
    }
}
