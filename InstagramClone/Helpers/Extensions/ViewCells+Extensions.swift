//
//  ViewCells+Extensions.swift
//  InstagramClone
//
//  Created by mehmet duran on 29.04.2023.
//

import UIKit

public extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
