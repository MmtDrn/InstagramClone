//
//  ProfileVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit
import Firebase

class ProfileVC: BaseViewController {
    
    private var viewModel: ProfileVM
    
    private lazy var profilTopView: ProfileTopView = {
        let view = ProfileTopView()
        
        view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: viewModel.profilType == .oneself ? 220 : 270)
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
    
    init(viewModel: ProfileVM, profilType: ProfilType) {
        self.viewModel = viewModel
        self.viewModel.profilType = profilType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    private func configureNavBar() {
        guard let type = viewModel.profilType else { return }
        switch type {
        case .oneself:
            self.setNavigationBar(navBarType: .profile(rightItemImage: UIImage(named: "threeTopPoint"),
                                                       title: Defs.shared.userModel?.userName),
                                  backItemHidden: true,
                                  isTransparent: true,
                                  backGroundColor: .systemGray6,
                                  rightButtonAction: #selector(navRightButtonTapped))
        case .anyone(let uid):
            self.setNavigationBar(navBarType: .postPresent(leftImage: UIImage(named: "leftArrow"),
                                                           leftTitle: viewModel.userName ?? "unkown"),
                                  backItemHidden: true,
                                  isTransparent: true,
                                  backGroundColor: .systemGray6,
                                  leftButtonAction: #selector(popToRoot))
            self.profilTopView.setButtonTitle(follow: viewModel.checkFollowStatus(uid: uid))
        }
    }
    
    @objc private func navRightButtonTapped() {
        viewModel.logOut()
    }
    
    @objc private func popToRoot() {
        navigationController?.popViewController(animated: true)
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
                self.configureNavBar()
                guard let profilType = self.viewModel.profilType else { return }
                self.profilTopView.setPostCountPF(profilType: profilType,
                                                  pfURL: self.viewModel.pfURL,
                                                  fullname: self.viewModel.fullName,
                                                  postCount: self.viewModel.postModels.count,
                                                  followerCount: self.viewModel.follower?.count ?? 0,
                                                  followingCount: self.viewModel.following?.count ?? 0)
                if !self.viewModel.postModels.isEmpty {
                    self.backView.setLabelHiddenStatus()
                }
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
                let postManager = FirebasePostManager.shared
                let chooseVM = ChoosePostVM(postManager: postManager)
                let choosePostVC = ChoosePostVC(viewModel: chooseVM, shareType: .profilImage)
                self.push(to: choosePostVC)
            
            case .toPresentPosts(let models, let index):
                let vc = PresentPostVC(presentType: .posts, models: models, scrollIndex: index)
                self.push(to: vc)
            }
        }
    }
}
