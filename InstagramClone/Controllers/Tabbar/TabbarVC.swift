//
//  TabbarController.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit
import WHTabbar

class TabbarVC: WHTabbarController {
    
    private lazy var viewModel = TabbarVM()
    
    private lazy var postButtonsView: PostButtonsView = {
        let view = PostButtonsView()
        
        view.delegate = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabbar()
        view.addSubview(postButtonsView)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(postViewStatus),
                                               name: .postViewStatus,
                                               object: nil)
        observeDataSource()
        observeViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: .postViewStatus,
                                                  object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configCenterButton()
        postButtonsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(centerButtonImageSize + CGFloat.dHeight * (20/812))
            make.height.equalTo(CGFloat.dHeight * (50/812))
            make.width.equalTo(CGFloat.dHeight * (110/812))
        }
    }
    
    private func configureTabbar() {
        tabBar.tintColor = .label
        
        let homeVC = createVC(item: .Home)
        let searchVC = createVC(item: .Search)
        let postVC = createVC(item: .Post)
        let notificationsVC = createVC(item: .Notifications)
        let profileVC = createVC(item: .Profile)
        
        viewControllers = [homeVC, searchVC, postVC, notificationsVC, profileVC]
    }
    
    private func createVC(item: TabbarItem) -> UIViewController {
        
        guard let vc = item.viewController,
              let icon = item.icon,
              let selectedIcon = item.selectedIcon else { return UIViewController() }
        
        let rootVC = UINavigationController(rootViewController: vc)
        if item == .Profile {
            rootVC.tabBarItem = UITabBarItem(title: nil, image: icon, selectedImage: icon)
        } else {
            rootVC.tabBarItem = UITabBarItem(title: nil, image: icon, selectedImage: selectedIcon)
        }
        
        return rootVC
    }
    
    private func configCenterButton() {
        
        centerButtonSize  = CGFloat.dHeight * (60/812)
        centerButtonBackroundColor =  .clear
        centerButtonBorderColor  =  .clear
        centerButtonBorderWidth = 4
        centerButtonImageSize = CGFloat.dHeight * (90/812)
        centerButtonImage = UIImage(named: "centerButton")
        
        setupCenetrButton(vPosition: 0) { [weak self] in
            guard let self = self else { return }
            self.postButtonsView.showing = !(self.postButtonsView.showing)
            
        }
    }
    
    @objc private func postViewStatus() {
        if !postButtonsView.isHidden {
            postButtonsView.isHidden = true
        }
    }
    
    private func observeDataSource() {
        
    }
    
    private func observeViewModel() {
        viewModel.subscribe { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .pushPostVC:
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(ChoosePostVC(shareType: .post), animated: true)
                }
            case .showAlert:
                DispatchQueue.main.async {
                    AlertManager.shared.showAlert(onVC: self,
                                                  type: .doubleButton(message: "Please grant permission to access your photo library in Settings.",
                                                                      firstButtonTitle: "Cancel",
                                                                      secondButtonTitle: "Settings")) {
                        NotificationCenter.default.post(name: .alertViewDismiss, object: nil)
                    } secondActionCompletion: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }

                }
                
            }
        }
    }
}

extension TabbarVC: PostButtonsProtocol {
    
    func cameraTapped() {
        viewModel.cameraButtonTapped()
    }
    
    func libraryTapped() {
        viewModel.requestPhotoLibraryAuthorization()
    }
    
}
