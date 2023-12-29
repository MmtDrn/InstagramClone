//
//  HomeVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit

class HomeVC: BaseViewController {
    
    private let viewModel: HomeVM
    
    private lazy var collectionView: BaseCollectionView = {
        let collectionView = BaseCollectionView(layout: createLayoutDifferentSection(),
                                                cells: [StoryCVCell.self,
                                                        HomeCVCell.self],
                                                showsVerticalScrollIndicator: false,
                                                showsHorizontalScrollIndicator: false)
        
        collectionView.dataSource = viewModel.dataSource
        collectionView.delegate = viewModel.dataSource
        
        return collectionView
    }()
    
    init(viewModel: HomeVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar(navBarType: .home(rightItemImage: UIImage(named: "direct"),
                                                leftItemImage: UIImage(named: "instagramName")),
                              backItemHidden: true,
                              isTransparent: true,
                              backGroundColor: .white,
                              rightButtonAction: #selector(navDirectButtonTapped))
        viewModel.getAllPostData()
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(collectionView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func navDirectButtonTapped() {
        print("direct button tapped")
    }
    
    override func observeViewModel() {
        super.observeViewModel()
        viewModel.subscribe { [weak self] state in
            guard let self else { return }
            switch state {
                
            case .fetcPostsError(let message):
                AlertManager.shared.showAlert(onVC: self, type: .justMessage(message: message))
            case .fetcPostsSuccess:
                self.collectionView.reloadData()
            }
        }
    }
    
    override func observeDataSource() {
        super.observeDataSource()
        viewModel.dataSource.subscribe { [weak self] state in
            guard let self else { return }
            switch state {
                
            case .navigateToProfil(let uid):
                let profileVM = ProfileVM(authManager: FirebaseAuthManager.shared,
                                          postManager: FirebasePostManager.shared,
                                          userDataManager: FirebaseUserDataManager.shared)
                let profileVC = ProfileVC(viewModel: profileVM, profilType: .anyone(uid: uid))
                self.push(to: profileVC)
            }
        }
    }
    
    func createLayoutDifferentSection() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return self.storyLayout()
            } else {
                return self.postLayout()
            }
        }
            
        return layout
    }
    
    func postLayout() -> NSCollectionLayoutSection  {
        let postCase = NSCollectionLayoutItem(layoutSize:
                                                NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                       heightDimension: .fractionalHeight(1)))
        
        let postGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                           heightDimension: .absolute(570)),
                                                         subitems: [postCase])
        
        
        let postSection = NSCollectionLayoutSection(group: postGroup)
        
        return postSection
    }
    
    func storyLayout() -> NSCollectionLayoutSection  {
        let storyCase = NSCollectionLayoutItem(layoutSize:
                                                NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                       heightDimension: .fractionalHeight(1)))
        
        let storyGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(80),
                                                                              heightDimension: .absolute(80)),
                                                            subitems: [storyCase])
        let storySection = NSCollectionLayoutSection(group: storyGroup)
        
        storySection.orthogonalScrollingBehavior = .continuous
        
        return storySection
    }
}
