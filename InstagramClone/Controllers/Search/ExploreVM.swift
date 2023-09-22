//
//  SearchVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 13.06.2023.
//

import UIKit

enum ExploreVMStateChange: StateChange {
    case fetchError
    case allPostFetched
}

class ExploreVM: StatefulVM<ExploreVMStateChange> {
    
    private let postManager: PostManagerProtocol
    private let defsManager: DefsProtocol
    
    let dataSource = ExploreDS()
    var posts = [PostModel]()
    
    init(postManager: PostManagerProtocol, defsManager: DefsProtocol) {
        self.postManager = postManager
        self.defsManager = defsManager
    }
    
    func getSelfUID() -> String? {
        if let selfUID = defsManager.userModel?.uuid {
            return selfUID
        } else {
            return nil
        }
    }
    
    public func getAllpost() {
        guard let selfUID = getSelfUID() else { return }
        postManager.getAllPosts { [weak self] (posts, error) in
            guard let self else { return }
            
            if let _ = error {
                self.emit(.fetchError)
            } else if let posts {
                self.dataSource.posts = posts.filter({ $0.authorUID != selfUID })
                self.posts = posts.filter({ $0.authorUID != selfUID })
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
