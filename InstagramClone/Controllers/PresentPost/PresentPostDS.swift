//
//  PresentPostDS.swift
//  InstagramClone
//
//  Created by mehmet duran on 9.06.2023.
//

import UIKit

enum PresentPostDSStateChange: StateChange {
    case scrollToRow
}

class PresentPostDS: StatefulDS<PresentPostDSStateChange> {
    var models = [PostModel]()
    private var scroolStatus = true
}

extension PresentPostDS: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTVCell.identifier, for: indexPath) as! HomeTVCell
        cell.setModel(model: model)
        if indexPath.row == 0 {
            cell.setCornerRadius()
        } else if (indexPath.row == indexPath.last) && scroolStatus {
            scroolStatus = false
            emit(.scrollToRow)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 570
    }
}
