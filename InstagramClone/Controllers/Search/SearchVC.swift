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
        FirebaseAuthManager.shared.getAllUsers()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(gesture:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
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
