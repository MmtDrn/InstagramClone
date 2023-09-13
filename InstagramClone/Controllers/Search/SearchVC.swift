//
//  SearchVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit
import FirebaseFirestore

class SearchVC: BaseViewController {

    private let viewModel: SearchVM
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = viewModel.dataSource
        
        return searchBar
    }()
    
    private lazy var collectionView: BaseCollectionView = {
        let collectionView = BaseCollectionView(layout: viewModel.createCompositionalLayout(),
                                                cells: [ExploreCell.self],
                                                showsVerticalScrollIndicator: false,
                                                showsHorizontalScrollIndicator: false,
                                                backgroundColor: .clear)

        collectionView.dataSource = viewModel.dataSource
        collectionView.delegate = viewModel.dataSource

        return collectionView
    }()
    
    init(viewModel: SearchVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        viewModel.getAllpost()
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.dWidth * (20/375))
            make.top.equalToSuperview().offset(CGFloat.dHeight * (50/812))
            make.height.equalTo(CGFloat.dHeight * (34/812))
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(4)
            make.top.equalTo(searchBar.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
        }
    }
    
    override func observeViewModel() {
        super.observeViewModel()
        viewModel.subscribe { [weak self] state in
            guard let self else { return }
            
            switch state {
                
            case .fetchError:
                print("fetch error")
            case .allPostFetched:
                self.collectionView.reloadData()
            }
        }
    }
    
    override func observeDataSource() {
        super.observeDataSource()
        viewModel.dataSource.subscribe { [weak self] state in
            guard let self else { return }
            
            switch state {
                
            case .clickPost(let cell):
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                let presentPostVC = PresentPostVC(presentType: .explore, models: self.viewModel.posts,
                                                  scrollIndex: indexPath.item)
                self.push(to: presentPostVC)
            }
        }
    }
}
