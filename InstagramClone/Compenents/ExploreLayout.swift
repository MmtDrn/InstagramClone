//
//  ExploreLayout.swift
//  InstagramClone
//
//  Created by mehmet duran on 11.07.2023.
//

import UIKit

class ExploreLayout: UICollectionViewLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let insets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let topGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4))
        
        let topSmallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let topLargeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1))
        
        let topSmallItem = NSCollectionLayoutItem(layoutSize: topSmallItemSize)
        topSmallItem.contentInsets = insets
        
        let topLargeItem = NSCollectionLayoutItem(layoutSize: topLargeItemSize)
        topLargeItem.contentInsets = insets
        
        let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: topGroupSize, subitems: [topSmallItem, topLargeItem])
        
        let midLargeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1))
        let midSmallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2))
        
        let midLargeItem = NSCollectionLayoutItem(layoutSize: midLargeItemSize)
        midLargeItem.contentInsets = insets
        let midSmallItem = NSCollectionLayoutItem(layoutSize: midSmallItemSize)
        midSmallItem.contentInsets = insets
        
        let midNestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        
        let midNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: midNestedGroupSize, subitems: [midSmallItem])
        
        let midGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2))
        
        let midGroup = NSCollectionLayoutGroup.horizontal(layoutSize: midGroupSize, subitems: [midLargeItem, midNestedGroup])
        
        let bottomItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4))
        
        let bottomItem = NSCollectionLayoutItem(layoutSize: bottomItemSize)
        bottomItem.contentInsets = insets
        
        // Reversed
        let topGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: topGroupSize, subitems: [topLargeItem, topSmallItem])
        let midGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: midGroupSize, subitems: [midNestedGroup, midLargeItem])
        
        let fullGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(650))
        let fullGroup = NSCollectionLayoutGroup.vertical(layoutSize: fullGroupSize, subitems: [topGroup, midGroup, bottomItem, topGroup2, midGroup2, bottomItem])
        
        let section = NSCollectionLayoutSection(group: fullGroup)
        
        collectionView.setCollectionViewLayout(UICollectionViewCompositionalLayout(section: section), animated: false)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForItem(at: indexPath)
    }
    
    override var collectionViewContentSize: CGSize {
        return super.collectionViewContentSize
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return super.shouldInvalidateLayout(forBoundsChange: newBounds)
    }
}

