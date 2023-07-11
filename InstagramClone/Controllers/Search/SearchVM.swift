//
//  SearchVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 13.06.2023.
//

import UIKit

enum SearchVMStateChange: StateChange {
    case fetchError
    case allPostFetched
}

class SearchVM: StatefulVM<SearchVMStateChange> {
    let dataSource = SearchDS()
    var posts = [PostModel]()
    
    public func getAllpost() {
        FirebasePostManager.shared.getAllPosts { [weak self] (posts, error) in
            guard let self else { return }
            
            if let _ = error {
                self.emit(.fetchError)
            } else if let posts {
                self.dataSource.posts = posts
                self.posts = posts
                self.emit(.allPostFetched)
            }
        }
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
            let insets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
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
            
            
            // reversed
            let topGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: topGroupSize, subitems: [topLargeItem, topSmallItem])
            let midGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: midGroupSize, subitems: [midNestedGroup, midLargeItem])
            
            let fullGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(650))
            let fullGroup = NSCollectionLayoutGroup.vertical(layoutSize: fullGroupSize, subitems: [topGroup, midGroup, bottomItem, topGroup2, midGroup2, bottomItem])
            
            let section = NSCollectionLayoutSection(group: fullGroup)
            
            let layout = UICollectionViewCompositionalLayout(section: section)
            
            return layout
        }
}
