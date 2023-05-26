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
        do {
            try Auth.auth().signOut()
            presentNavigate(to: LoginVC())
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
