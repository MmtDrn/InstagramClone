//
//  PostVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit
import SnapKit

class PostVC: BaseViewController {
    
    private lazy var viewModel = PostVM()
    
    private lazy var navView: PostNavView = {
        let view = PostNavView(title: "New Post")
        
        view.delegate = self
        
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.viewModel.choseImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.choseImage()
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(navView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.dHeight * (30/812))
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * (70/812))
        }
    }
    
    override func observeViewModel() {
        super.observeViewModel()
    }
    
    override func observeDataSource() {
        super.observeDataSource()
        
        viewModel.dataSource.subscribe { state in
            switch state {
                
            case .setImage(let image):
                break
            case .cancel:
                self.navLeftButtonAction()
            }
        }
    }
}

//MARK: - Navigation Button Actions
extension PostVC: PostNavViewProtocol {
    
    func navRightButtonAction() {
        print("post nav right button tapped")
    }
    
    func navLeftButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}
