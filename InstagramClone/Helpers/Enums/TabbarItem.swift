//
//  TabbarItem.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit

enum TabbarItem: Int {
    case Home
    case Search
    case Post
    case Notifications
    case Profile
    
    var icon: UIImage? {
        switch self {
        case .Home:
            return UIImage(systemName: "house") ?? .add
        case .Search:
            return UIImage(systemName: "magnifyingglass") ?? .add
        case .Notifications:
            return UIImage(systemName: "heart") ?? .add
        case .Profile:
            return UIImage(systemName: "person") ?? .add
        case .Post:
            return nil
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .Home:
            return UIImage(systemName: "house.fill") ?? .add
        case .Search:
            return UIImage(systemName: "magnifyingglass") ?? .add
        case .Notifications:
            return UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) ?? .add
        case .Profile:
            return UIImage(systemName: "person.fill") ?? .add
        case .Post:
            return nil
        }
    }
    
    var viewController: UIViewController? {
        switch self {
        case .Home:
            return HomeVC()
        case .Search:
            return SearchVC()
        case .Notifications:
            return NotificationsVC()
        case .Profile:
            return ProfileVC()
        case .Post:
            return nil
        }
    }
}
