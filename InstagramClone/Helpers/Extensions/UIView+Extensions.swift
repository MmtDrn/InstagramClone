//
//  UIView+Extensions.swift
//  InstagramClone
//
//  Created by mehmet duran on 8.06.2023.
//

import UIKit

extension UIView {
    public func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
}
