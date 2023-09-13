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
            guard let urlString = Defs.shared.userModel?.profilImageURL,
                  let url = URL(string: urlString) else { return UIImage(systemName: "person") ?? .add }
            
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                let image = image.resize(to: CGSize(width: 30, height: 30))
                let imageView = UIImageView(image: image)
                imageView.layer.cornerRadius = 15
                imageView.clipsToBounds = true
                imageView.layer.borderColor = UIColor.gray.cgColor
                imageView.layer.borderWidth = 0.5
                let renderer = UIGraphicsImageRenderer(size: imageView.bounds.size)
                let roundedImage = renderer.image { context in
                    imageView.layer.render(in: context.cgContext)
                }
                return roundedImage.withRenderingMode(.alwaysOriginal)
            }
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
            let postManager = FirebasePostManager.shared
            let homeVM = HomeVM(postManager: postManager)
            let homeVC = HomeVC(viewModel: homeVM)
            return homeVC
        case .Search:
            let postManager = FirebasePostManager.shared
            let searchVM = SearchVM(postManager: postManager)
            let searchVC = SearchVC(viewModel: searchVM)
            return searchVC
        case .Notifications:
            return NotificationsVC()
        case .Profile:
            let profileVM = ProfileVM(authManager: FirebaseAuthManager.shared,
                                      postManager: FirebasePostManager.shared,
                                      userDataManager: FirebaseUserDataManager.shared)
            let profileVC = ProfileVC(viewModel: profileVM, profilType: .oneself)
            return profileVC
        case .Post:
            return nil
        }
    }
}
