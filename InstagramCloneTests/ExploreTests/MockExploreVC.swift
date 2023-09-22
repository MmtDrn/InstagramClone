//
//  MockExploreVC.swift
//  InstagramCloneTests
//
//  Created by mehmet duran on 22.09.2023.
//

@testable import InstagramClone

class MockExploreVC {
    
    private let viewModel: ExploreVM
    
    var postFetchedSuccess = false
    var postFetchedFailure = false
    var clickPost = false
    
    init(viewModel: ExploreVM) {
        self.viewModel = viewModel
        observeViewModel()
        observeDataSource()
    }
    
    func observeViewModel() {
        viewModel.subscribe { state in
            switch state {
                
            case .fetchError:
                self.postFetchedFailure = true
            case .allPostFetched:
                self.postFetchedSuccess = true
            }
        }
    }
    
    func observeDataSource() {
        viewModel.dataSource.subscribe { state in
            switch state {
                
            case .clickPost(_):
                self.clickPost = true
            }
        }
    }
}
