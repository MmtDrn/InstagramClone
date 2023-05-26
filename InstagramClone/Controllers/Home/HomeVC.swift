//
//  HomeVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit

class HomeVC: BaseViewController {
    
    private let viewModel = HomeVM()
    
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(cells: [HomeTVCell.self],
                                      showsVerticalScrollIndicator: false,
                                      separatorStyle: .none,
                                      backgroundColor: .clear)
        
        tableView.dataSource = viewModel.dataSource
        tableView.delegate = viewModel.dataSource
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar(navBarType: .home(rightItemImage: UIImage(named: "direct"),
                                                leftItemImage: UIImage(named: "instagramName")),
                              backItemHidden: true,
                              isTransparent: true,
                              backGroundColor: .white,
                              rightButtonAction: #selector(navDirectButtonTapped))
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(tableView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func navDirectButtonTapped() {
        print("direct button tapped")
    }
}
