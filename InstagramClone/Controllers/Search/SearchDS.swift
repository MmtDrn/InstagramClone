//
//  SearchDS.swift
//  InstagramClone
//
//  Created by mehmet duran on 13.06.2023.
//

import UIKit

enum SearchDSStateChange: StateChange {
    
}

class SearchDS: StatefulDS<SearchDSStateChange> {
    
}

extension SearchDS: UISearchBarDelegate {
    
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
