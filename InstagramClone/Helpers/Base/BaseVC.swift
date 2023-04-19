//
//  BaseNavigationController.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        observeViewModel()
        observeDataSource()
        setupViews()
        setupLayouts()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .postViewStatus, object: nil)
    }
    
    deinit {
        print("OS reclaiming memory for: \(self.classForCoder)")
    }
    
    @objc open func observeViewModel() {}
    @objc open func observeDataSource() {}
    @objc open func setupViews() {}
    @objc open func setupLayouts() {}
}

//MARK: NavigationBar Setup Funcs
extension BaseViewController {
    
    func setNavigationBar(navBarType: NavbarEnum?,
                          prefersLargeTitles: Bool = false,
                          backItemHidden:Bool = false,
                          backItemImage: String? = nil,
                          tintColor: UIColor = .black,
                          isTransparent: Bool = false,
                          backGroundColor: UIColor = .clear,
                          backButtonAction: Selector? = #selector(endEditing),
                          rightButtonAction: Selector? = #selector(endEditing),
                          leftButtonAction: Selector? = #selector(endEditing)) {
        
        if isTransparent {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.barTintColor = .clear
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
            self.navigationController?.navigationBar.isTranslucent = true
        } else {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.barTintColor  = backGroundColor
            self.navigationItem.largeTitleDisplayMode = prefersLargeTitles ? .always : .never
        }
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.prefersLargeTitles =  prefersLargeTitles
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.additionalSafeAreaInsets = .zero
        
        self.navigationController?.navigationBar.sizeThatFits(CGSize(width: CGFloat.dWidth, height: 70))
        
        switch navBarType {
            
        case .home(let image, let image2):
            setNavbarButtonItems(rightImage: image,
                                 rightButtonAction: rightButtonAction,
                                 leftImage: image2,
                                 leftButtonAction: leftButtonAction)
        case .profile(let rightItemImage, let title):
            if self.tabBarController != nil {
                navigationItem.title = title
            } else {
                self.title = title
            }
            setNavbarButtonItems(rightImage: rightItemImage, rightButtonAction: rightButtonAction, leftImage: nil, leftButtonAction: nil)
        case .post(let title, let rightImage, let leftImage):
            if self.tabBarController != nil {
                navigationItem.title = title
            } else {
                self.title = title
            }
            setNavbarButtonItems(rightImage: rightImage, rightButtonAction: rightButtonAction, leftImage: leftImage, leftButtonAction: leftButtonAction)
        case .justTitle(let title):
            if self.tabBarController != nil {
                navigationItem.title = title
            } else {
                self.title = title
            }
        case .none:
            break
        }
    }
    
    private func setNavbarButtonItems(rightImage: UIImage?,
                                      rightButtonAction: Selector?,
                                      leftImage: UIImage?,
                                      leftButtonAction: Selector?) {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        if let safeImage = rightImage, let actionRightButton = rightButtonAction {
            let rightButton = UIBarButtonItem(customView: createImageViewForNavbar(image: safeImage, action: actionRightButton))
            navigationItem.rightBarButtonItems?.append(rightButton)
        }
        if let image2 = leftImage, let leftButtonAction = leftButtonAction {
            let leftButton = UIBarButtonItem(customView: createImageViewForNavbar(image: image2, action: leftButtonAction))
            navigationItem.leftBarButtonItems?.append(leftButton)
        }
    }
    
    private func createImageViewForNavbar(image: UIImage, action: Selector?) -> UIImageView {
        let imageView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
        imageView.contentMode = .scaleAspectFill
        let gesture = UITapGestureRecognizer(target: self, action: action)
        imageView.addGestureRecognizer(gesture)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.dHeight * (28/812))
            make.height.equalTo(CGFloat.dHeight * (24/812))
        }
        return imageView
    }
    
    @objc public func endEditing(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    
    public func push(to: BaseViewController, animated: Bool = true) {
        navigationController?.pushViewController(to, animated: animated)
    }
    
    public func presentNavigate(to: UIViewController, animated: Bool = true,
                                presentationSyle: UIModalPresentationStyle = .fullScreen) {
        to.modalPresentationStyle = presentationSyle
        present(to, animated: animated)
    }
}
