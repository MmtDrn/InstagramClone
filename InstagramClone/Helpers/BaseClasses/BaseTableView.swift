//
//  BaseTableView.swift
//  InstagramClone
//
//  Created by mehmet duran on 26.05.2023.
//

import UIKit

class BaseTableView: UITableView {
    
    convenience init(style: Style = .plain,
                     cells: [BaseTableViewCell.Type],
                     allowsSelection: Bool = true,
                     allowsMultipleSelection: Bool = false,
                     isPagingEnabled: Bool = false,
                     isScrollEnabled: Bool = true,
                     showsVerticalScrollIndicator: Bool = true,
                     separatorStyle: UITableViewCell.SeparatorStyle = .singleLine,
                     separatorColor: UIColor? = .gray,
                     separatorInset: UIEdgeInsets = .zero,
                     scrollIndicatorInsets: UIEdgeInsets = .zero,
                     bounces: Bool = true,
                     tableHeaderView: UIView? = nil,
                     tableFooterView: UIView? = UIView(frame: .zero),
                     backgroundColor: UIColor? = .clear)
         {
        
        self.init(frame: .zero, style: style)
        
        for cell in cells {
            register(cell, forCellReuseIdentifier: cell.identifier)
        }
        
        self.allowsSelection = allowsSelection
        self.allowsMultipleSelection = allowsMultipleSelection
        self.isPagingEnabled = isPagingEnabled
        self.isScrollEnabled = isScrollEnabled
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.separatorStyle = separatorStyle
        self.separatorColor = separatorColor
        self.separatorInset = separatorInset
        self.scrollIndicatorInsets = scrollIndicatorInsets
        self.bounces = bounces
        
        if let header = tableHeaderView {
            self.tableHeaderView = header
        }
        
        if let footer = tableFooterView {
            self.tableFooterView = footer
        }
        
        self.backgroundColor = backgroundColor
            
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = .zero
        } else {
                // Fallback on earlier versions
        }
    }
}
