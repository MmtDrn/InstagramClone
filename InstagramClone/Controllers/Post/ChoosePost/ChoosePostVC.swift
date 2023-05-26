//
//  PostVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 30.03.2023.
//

import UIKit
import SnapKit

class ChoosePostVC: BaseViewController {
    
    private lazy var viewModel = ChoosePostVM()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar(navBarType: .post(title: "New Post",
                                                rightImage: UIImage(named: "rightArrow"),
                                                leftImage: UIImage(named: "xImage")),
                              backItemHidden: true,
                              isTransparent: true,
                              backGroundColor: .white,
                              rightButtonAction: #selector(doneButtonTapped),
                              leftButtonAction: #selector(cancelButtonTapped))
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
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func doneButtonTapped() {
        guard let image = imageView.image else { return }
        push(to: SharePostVC(image: image))
    }
    
    
    override func observeViewModel() {
        super.observeViewModel()
        
        viewModel.subscribe { [weak self] state in
            guard let self = self else { return }
            switch state {
                
            case .relodData:
                self.imageView.image = self.viewModel.dataSource.images.first
                self.collectionView.reloadData()
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
