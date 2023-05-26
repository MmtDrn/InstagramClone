//
//  BaseTableViewCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 26.05.2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc open func setupViews() {}
    @objc open func setupLayouts() {}
}
