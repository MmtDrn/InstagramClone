//
//  MockHomeVC.swift
//  InstagramCloneTests
//
//  Created by mehmet duran on 22.09.2023.
//

@testable import InstagramClone

final class MockHomeVC {
    private let viewModel: HomeVM
    
    var errorMessage: String?
    var reloatData = false
    
    init(viewModel: HomeVM) {
        self.viewModel = viewModel
        observeViewModel()
    }
    
    func observeViewModel() {
        viewModel.subscribe { state in
            switch state {
                
            case .fetcPostsError(let errorMessage):
                self.errorMessage = errorMessage
            case .fetcPostsSuccess:
                self.reloatData = true
            }
        }
    }
}
