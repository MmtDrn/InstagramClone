//
//  PostVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit
import SnapKit

class ChoosePostVC: BaseViewController {
    
    private var viewModel: ChoosePostVM
    
    private lazy var imageView: BaseImageView = {
        let imageView = BaseImageView(image: nil,
                                      contentMode: .scaleAspectFit,
                                      backgroundColor: .clear)
        
        return imageView
    }()
    
    private lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = BaseCollectionView(layout: layout,
                                                cells: [PostCell.self],
                                                allowsSelection: true,
                                                allowsMultipleSelection: true,
                                                backgroundColor: .clear)

        collectionView.delegate = viewModel.dataSource
        collectionView.dataSource = viewModel.dataSource

        return collectionView
    }()
    
    init(viewModel: ChoosePostVM, shareType: ShareType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.shareType = shareType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        viewModel.fetchImages()
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(imageView)
        view.addSubview(collectionView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(CGFloat.dHeight/3)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureNavBar() {
        guard let type = viewModel.shareType else { return }
        switch type {
        case .post:
            self.setNavigationBar(navBarType: .post(title: "New Post",
                                                    rightImage: UIImage(named: "rightArrow"),
                                                    leftImage: UIImage(named: "xImage")),
                                  backItemHidden: true,
                                  isTransparent: true,
                                  backGroundColor: .white,
                                  rightButtonAction: #selector(doneButtonTapped),
                                  leftButtonAction: #selector(cancelButtonTapped))
        case .profilImage:
            self.setNavigationBar(navBarType: .post(title: "New Profil Image",
                                                    rightImage: UIImage(named: "rightArrow"),
                                                    leftImage: UIImage(named: "xImage")),
                                  backItemHidden: true,
                                  isTransparent: true,
                                  backGroundColor: .white,
                                  rightButtonAction: #selector(doneButtonTapped),
                                  leftButtonAction: #selector(cancelButtonTapped))
        }
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func doneButtonTapped() {
        guard let image = imageView.image,
              let shareType = viewModel.shareType else { return }
        
        switch shareType {
        case .post:
            let postManager = FirebasePostManager.shared
            let sharePostViewModel = SharePostVM(postManager: postManager)
            let sharePostVC = SharePostVC(image: image, viewModel: sharePostViewModel)
            push(to: sharePostVC)
        case .profilImage:
            viewModel.setProfilImage(image: image)
        }
    }
    
    
    override func observeViewModel() {
        super.observeViewModel()
        
        viewModel.subscribe { [weak self] state in
            guard let self = self else { return }
            switch state {
                
            case .relodData:
                self.imageView.image = self.viewModel.dataSource.images.first
                self.collectionView.reloadData()
            case .setPFSuccess:
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    override func observeDataSource() {
        super.observeDataSource()
        viewModel.dataSource.subscribe { [weak self] state in
            guard let self = self else { return }
            
            switch state {
                
            case .setHeaderImage(let image):
                self.imageView.image = image
            }
        }
    }
}
