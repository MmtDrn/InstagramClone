//
//  SearchVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit

class SearchVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar(navBarType: .justTitle(title: "Search"),
                              backItemHidden: true,
                              isTransparent: true,
                              backGroundColor: .white)
    }
}
