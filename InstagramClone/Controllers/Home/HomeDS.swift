//
//  HomeDS.swift
//  InstagramClone
//
//  Created by mehmet duran on 26.05.2023.
//

import UIKit

enum HomeCase: CaseIterable {
    case story
    case post
}

enum HomeDSStateChange: StateChange {
    
}

class HomeDS: StatefulDS<HomeDSStateChange> {
    var models = [PostModel]()
}

extension HomeDS: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeCase.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch HomeCase.allCases[section] {
            
        case .story:
            return 1
        case .post:
            return models.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch HomeCase.allCases[indexPath.section] {
            
        case .story:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryTVCell.identifier, for: indexPath) as! StoryTVCell
            return cell
        case .post:
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTVCell.identifier, for: indexPath) as! HomeTVCell
            cell.setModel(model: model)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch HomeCase.allCases[indexPath.section] {
            
        case .story:
            return 100
        case .post:
            return 570
        }
        
    }
}
