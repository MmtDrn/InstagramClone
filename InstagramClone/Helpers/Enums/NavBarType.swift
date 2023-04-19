//
//  NavBarType.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit

enum NavbarEnum: Equatable {
    
    case home(rightItemImage: UIImage? = nil,
              leftItemImage: UIImage? = nil)
    
    case profile(rightItemImage: UIImage? = nil,
                 title: String? = nil)
    
    case post(title: String? = nil,
              rightImage: UIImage? = nil,
              leftImage: UIImage? = nil)
    
    case justTitle(title: String? = nil)
}
