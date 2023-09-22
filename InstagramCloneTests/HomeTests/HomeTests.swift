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
        mockPostManager = nil
        mockDefsManager = nil
        sutVM = nil
        mockHomeVC = nil
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
