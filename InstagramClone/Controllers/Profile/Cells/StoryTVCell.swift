//
//  StoryTVCell.swift
//  InstagramClone
//
//  Created by mehmet duran on 4.06.2023.
//

import UIKit

class StoryTVCell: BaseTableViewCell {
    
    private lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionView = BaseCollectionView(layout: layout,
                                                cells: [StoryCVCell.self],
                                                showsVerticalScrollIndicator: false,
                                                showsHorizontalScrollIndicator: false,
                                                backgroundColor: .clear)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func setupViews() {
        super.setupViews()
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 2, height: 6)
        self.layer.shadowRadius = 6
        let shadowPath = UIBezierPath(roundedRect: self.bounds.insetBy(dx: -10, dy: -10), cornerRadius: 20)
        self.layer.shadowPath = shadowPath.cgPath
        
        clipsToBounds = true
        contentView.addSubview(collectionView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension StoryTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCVCell.identifier, for: indexPath) as! StoryCVCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
