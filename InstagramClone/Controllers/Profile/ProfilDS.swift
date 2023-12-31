//
//  ProfilDS.swift
//  InstagramClone
//
//  Created by mehmet duran on 4.06.2023.
//

import UIKit

enum ProfilDSStateFull: StateChange {
    case setPF
    case toPresentPosts([PostModel], Int)
}

class ProfilDS: StatefulDS<ProfilDSStateFull> {
    
    let sections = ProfilSection.allCases
    var postModels = [PostModel]()
}

extension ProfilDS: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
            
        case .story:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryTVCell.identifier, for: indexPath) as! StoryTVCell
            return cell
        case .post:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePostTVCell.identifier, for: indexPath) as! ProfilePostTVCell
            cell.setModels(models: postModels)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        
        switch section {
        case .story:
            return 100
        case .post:
            if postModels.count%3 == 0 {
                return CGFloat((postModels.count/3 ) * 200)
            } else {
                return CGFloat((postModels.count/3 + 1) * 200)
            }
            
        }
    }
}

extension ProfilDS: ProfileTopViewProtocol, ProfilePostTVCellProtocol {
    
    func clickFallowButton() {
        print("click fallow button")
    }
    
    func clickMessageButton() {
        print("click message button")
    }
    
    func setIndex(index: Int) {
        emit(.toPresentPosts(postModels, index))
    }
    
    func clickImage() {
        emit(.setPF)
    }
    
    func clickFollowers() {
        print("clickFollowers")
    }
    
    func clickFollowing() {
        print("clickFollowing")
    }
}
