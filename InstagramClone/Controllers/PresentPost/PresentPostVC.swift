//
//  PresentPostVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 9.06.2023.
//

import UIKit

class PresentPostVC: BaseViewController {
    
    private let viewModel = PresentPostVM()
    
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(cells: [HomeTVCell.self],
                                      showsVerticalScrollIndicator: false,
                                      separatorStyle: .none,
                                      backgroundColor: .clear)
        
        tableView.dataSource = viewModel.dataSource
        tableView.delegate = viewModel.dataSource
        
        return tableView
    }()
    
    init(models: [PostModel], scrollIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel.dataSource.models = models
        self.viewModel.scrollIndex = scrollIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar(navBarType: .postPresent(leftImage: UIImage(named: "leftArrow"),
                                                       leftTitle: "Posts"),
                              backItemHidden: true,
                              isTransparent: true,
                              backGroundColor: .white,
                              leftButtonAction: #selector(backAction))
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(tableView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    override func observeDataSource() {
        super.observeDataSource()
        viewModel.dataSource.subscribe { [weak self] state in
            guard let self else { return }
            switch state {
                
            case .scrollToRow:
                guard let row = self.viewModel.scrollIndex else { return }
                self.tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .top, animated: false)
            }
        }
    }
}
