//
//  ProfileVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit
import Firebase

class ProfileVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar(navBarType: .profile(rightItemImage: UIImage(named: "menu"),
                                                   title: "nickname"),
                              backItemHidden: true,
                              isTransparent: true,
                              backGroundColor: .white,
                              rightButtonAction: #selector(navRightButtonTapped))
    }
    
    @objc private func navRightButtonTapped() {
        FirebaseManager.shared.logOut()
    }
    
}
