//
//  ExploreTests.swift
//  InstagramCloneTests
//
//  Created by mehmet duran on 22.09.2023.
//

import XCTest
@testable import InstagramClone

final class ExploreTests: XCTestCase {
    
    private var viewModel: ExploreVM!
    private var mockPostManager: MockPostManager!
    private var mockDefsManager: MockDefs!
    private var mockExploreVC: MockExploreVC!
    
    override func setUpWithError() throws {
        mockPostManager = MockPostManager()
        mockDefsManager = MockDefs()
        viewModel = .init(postManager: mockPostManager, defsManager: mockDefsManager)
        mockExploreVC = .init(viewModel: viewModel)
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testVM_getSelfUID_WhenSuccess() throws {
        mockDefsManager.mockUserModel = .init()
        mockDefsManager.mockUserModel?.uuid = "uuid"
        
        XCTAssertEqual(viewModel.getSelfUID(), "uuid")
    }
    
    func testVM_getSelfUID_WhenFailure() throws {
        mockDefsManager.mockUserModel = .init()
        mockDefsManager.mockUserModel?.uuid = nil
        
        XCTAssertNil(viewModel.getSelfUID())
    }
    
    func testVM_getAllpost_WhenSuccess() throws {
        mockDefsManager.mockUserModel = .init()
        mockDefsManager.mockUserModel?.uuid = "uuid"
        mockPostManager.result = ([], nil)
        
        viewModel.getAllpost()
        
        XCTAssertTrue(mockExploreVC.postFetchedSuccess)
    }
    
    func testVM_getAllpost_WhenFailure() throws {
        mockDefsManager.mockUserModel = .init()
        mockDefsManager.mockUserModel?.uuid = "uuid"
        mockPostManager.result = (nil, .backendError)
        
        viewModel.getAllpost()
        
        XCTAssertTrue(mockExploreVC.postFetchedFailure)
    }
}

class MockExploreVC {
    
    private let viewModel: ExploreVM
    
    var postFetchedSuccess = false
    var postFetchedFailure = false
    
    init(viewModel: ExploreVM) {
        self.viewModel = viewModel
        observeViewModel()
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
}
