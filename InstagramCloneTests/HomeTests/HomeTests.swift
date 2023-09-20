//
//  HomeTest.swift
//  InstagramCloneTests
//
//  Created by mehmet duran on 14.09.2023.
//

import XCTest
@testable import InstagramClone

final class HomeTests: XCTestCase {
    
    private var sutVM: HomeVM!
    private var mockPostManager: MockPostManager!
    private var mockDefsManager: MockDefs!
    private var mockHomeVC: MockHomeVC!
    
    override func setUpWithError() throws {
        mockPostManager = MockPostManager()
        mockDefsManager = MockDefs()
        sutVM = HomeVM(postManager: mockPostManager, defsManager: mockDefsManager)
        mockHomeVC = MockHomeVC(viewModel: sutVM)
    }
    
    override func tearDownWithError() throws {
    }
    
    func testFetchFollowedPost_whenSuccess() throws {
        mockPostManager.result = ([], nil)
        mockDefsManager.mockUserModel = DefsUserModel()
        mockDefsManager.mockUserModel?.followingUID = [""]
        
        sutVM.getAllPostData()
        XCTAssertEqual(mockHomeVC.reloatData, true)
    }
    
    func testFetchFollowedPost_whenFailure() throws {
        mockPostManager.result = (nil, .backendError)
        mockDefsManager.mockUserModel = DefsUserModel()
        mockDefsManager.mockUserModel?.followingUID = [""]
        
        sutVM.getAllPostData()
        XCTAssertEqual(mockHomeVC.reloatData, false)
        XCTAssertEqual(mockHomeVC.errorMessage, "An unexpected error has occurred.")
    }

    func testFetchFollowedPerson_whenSuccess() throws {
        mockDefsManager.mockUserModel = DefsUserModel()
        mockDefsManager.mockUserModel?.followingUID = [""]

        let followingPersons = sutVM.getFollowedPersons()

        XCTAssertEqual(followingPersons?.first, [""].first)
    }

    func testFetchFollowedPerson_whenFailure() throws {
        let followingPersons = sutVM.getFollowedPersons()

        XCTAssertEqual(followingPersons, nil)
    }
}

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

final class MockPostManager: PostManagerProtocol {
    var result: ([PostModel]?, FetchError?)?
    func followedPosts(follwedPersons: [String], completion: @escaping ([PostModel]?, FetchError?) -> Void) {
        if let result {
            completion(result.0, result.1)
        }
    }
}
