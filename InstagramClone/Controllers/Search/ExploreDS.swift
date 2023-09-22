//
//  SearchDS.swift
//  InstagramClone
//
//  Created by mehmet duran on 13.06.2023.
//

import UIKit

enum ExploreDSStateChange: StateChange {
    case clickPost(BaseCollectionViewCell)
}

class ExploreDS: StatefulDS<ExploreDSStateChange> {
    var posts:[PostModel] = []
}

extension ExploreDS: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCell.identifier, for: indexPath) as! ExploreCell
        let post = posts[indexPath.item]
        
        cell.setView(model: post)
        cell.delegate = self
        
        return cell
    }
}

extension ExploreDS: ExploreCellProtocol {
    
    func clickPost(cell: BaseCollectionViewCell) {
        emit(.clickPost(cell))
    }
}

extension ExploreDS: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("begin")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("end")
    }
}
