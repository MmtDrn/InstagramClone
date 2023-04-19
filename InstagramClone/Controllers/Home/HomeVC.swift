//
//  HomeVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit
import ProgressHUD

class HomeVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar(navBarType: .home(rightItemImage: UIImage(named: "direct"),
                                                leftItemImage: UIImage(named: "instagramName")),
                              backItemHidden: true,
                              isTransparent: true,
                              backGroundColor: .white,
                              rightButtonAction: #selector(navDirectButtonTapped))
    }
    
    @objc private func navDirectButtonTapped() {
        print("direct button tapped")
    }
}
