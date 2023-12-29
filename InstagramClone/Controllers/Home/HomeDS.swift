//
//  HomeDS.swift
//  InstagramClone
//
//  Created by mehmet duran on 26.05.2023.
//

import UIKit

enum HomeDSStateChange: StateChange {
    case navigateToProfil(uid: String)
}

class HomeDS: StatefulDS<HomeDSStateChange> {
    var models = [PostModel]()
}

extension HomeDS: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeCase.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch HomeCase.allCases[section] {
            
        case .story:
            return 20
        case .post:
            return models.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch HomeCase.allCases[indexPath.section] {
            
        case .story:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCVCell.identifier, for: indexPath) as! StoryCVCell
            return cell
        case .post:
            let model = models[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCVCell.identifier, for: indexPath) as! HomeCVCell
            cell.setModel(model: model)
            cell.delegate = self
            return cell
        }
    }
}

extension HomeDS: HomeTVCellProtocol {
    
    func setUID(uid: String) {
        emit(.navigateToProfil(uid: uid))
    }
}
