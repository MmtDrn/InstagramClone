//
//  ProfilePostTVCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 5.06.2023.
//

import UIKit

protocol ProfilePostTVCellProtocol: AnyObject {
    func setIndex(index: Int)
}

class ProfilePostTVCell: BaseTableViewCell {
    
    private var postModels = [PostModel]()
    weak var delegate: ProfilePostTVCellProtocol?
    
    private lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionView = BaseCollectionView(layout: layout,
                                                cells: [ProfilePostCVCell.self],
                                                showsVerticalScrollIndicator: false,
                                                showsHorizontalScrollIndicator: false,
                                                backgroundColor: .clear)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(collectionView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func setModels(models: [PostModel]) {
        self.postModels = models
        self.collectionView.reloadData()
    }
}

extension ProfilePostTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePostCVCell.identifier, for: indexPath) as! ProfilePostCVCell
        let model = postModels[indexPath.item]
        
        cell.setView(model: model)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (CGFloat.dWidth/3) - 10, height: 180)
    }
}

extension ProfilePostTVCell: ProfilePostCVCellProtocol {
    
    func setIndexPath(cell: BaseCollectionViewCell) {
        let indexPath = collectionView.indexPath(for: cell)
        guard let index = indexPath?.item else { return }
        delegate?.setIndex(index: index)
    }
}
