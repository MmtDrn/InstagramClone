//
//  NotificationsVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit

class NotificationsVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar(navBarType: .justTitle(title: "Notifications"),
                              backItemHidden: true,
                              isTransparent: true,
                              backGroundColor: .white)
    }
}
