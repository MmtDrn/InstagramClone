//
//  PostDS.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit

enum ChoosePostDSStateChange: StateChange {
    case setHeaderImage(image: UIImage)
}

class ChoosePostDS: StatefulDS<ChoosePostDSStateChange> {
    var images: [UIImage] = []
}

extension ChoosePostDS: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.identifier, for: indexPath) as! PostCell
        let image = images[indexPath.item]
        
        cell.setImage(image: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.item]
        emit(.setHeaderImage(image: image))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (CGFloat.dWidth/4)-10, height: (CGFloat.dWidth/4)-10)
    }
}
