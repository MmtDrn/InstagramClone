//
//  SearchVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 13.06.2023.
//

import UIKit

enum SearchVMStateChange: StateChange {
    
}

class SearchVM: StatefulVM<SearchVMStateChange> {
    let dataSource = SearchDS()
}
