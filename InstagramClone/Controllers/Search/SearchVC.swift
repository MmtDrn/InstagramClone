//
//  SearchVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit
import FirebaseFirestore

class SearchVC: BaseViewController {

    private let viewModel = SearchVM()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = viewModel.dataSource
        
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(searchBar)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.dWidth * (20/375))
            make.top.equalToSuperview().offset(CGFloat.dHeight * (50/812))
            make.height.equalTo(CGFloat.dHeight * (34/812))
        }
    }
    
    override func observeDataSource() {
        super.observeDataSource()
        viewModel.dataSource.subscribe { [weak self] state in
            guard let self else { return }
            
        }
    }
}
