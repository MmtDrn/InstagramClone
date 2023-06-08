//
//  ProfileVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit
import Firebase

class ProfileVC: BaseViewController {
    
    private var viewModel = ProfileVM()
    
    private lazy var profilTopView: ProfileTopView = {
        let view = ProfileTopView()
        
        view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 220)
        view.delegate = viewModel.dataSource
        
        return view
    }()
    
    private lazy var backView: ProfileBackView = {
        let view = ProfileBackView(backGroundColor: .white)
        return view
    }()
    
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(style: .plain,
                                      cells: [StoryTVCell.self,
                                              ProfilePostTVCell.self],
                                      showsVerticalScrollIndicator: false,
                                      separatorStyle: .none,
                                      tableHeaderView: profilTopView,
                                      backgroundColor: .clear)
        
        tableView.dataSource = viewModel.dataSource
        tableView.delegate = viewModel.dataSource
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar(navBarType: .profile(rightItemImage: UIImage(named: "threeTopPoint"),
                                                   title: Defs.shared.userModel?.userName),
                              backItemHidden: true,
                              isTransparent: true,
                              backGroundColor: .systemGray6,
                              rightButtonAction: #selector(navRightButtonTapped))
        navigationController?.navigationBar.backgroundColor = .systemGray6
        view.backgroundColor = .systemGray6
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getPostData()

    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(backView)
        view.addSubview(tableView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        backView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight/1.8)
        }
    }
    
    @objc private func navRightButtonTapped() {
        viewModel.logOut()
    }
    
    override func observeViewModel() {
        super.observeViewModel()
        viewModel.subscribe { [weak self] state in
            guard let self else { return
                
            }
            switch state {
                
            case .showAlert(let message):
                AlertManager.shared.showAlert(onVC: self, type: .justMessage(message: message))
            case .setPostModelsSuccess:
                self.profilTopView.setPostCount(count: self.viewModel.postModels.count)
                self.backView.setLabelHiddenStatus()
                self.tableView.reloadData()
            }
        }
    }
    
    override func observeDataSource() {
        super.observeDataSource()
        viewModel.dataSource.subscribe { [weak self] state in
            guard let self else { return }
            switch state {
                
            case .setPF:
                self.push(to: ChoosePostVC(shareType: .profilImage))
            }
        }
    }
}
