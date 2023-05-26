//
//  HomeDS.swift
//  InstagramClone
//
//  Created by mehmet duran on 26.05.2023.
//

import UIKit

enum HomeDSStateChange: StateChange {
    
}

class HomeDS: StatefulDS<HomeDSStateChange> {
    
}

extension HomeDS: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTVCell.identifier, for: indexPath) as! HomeTVCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
}
