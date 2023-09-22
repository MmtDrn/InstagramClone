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
    private var mockTableView: UITableView!
    
    override func setUpWithError() throws {
        mockPostManager = MockPostManager()
        mockDefsManager = MockDefs()
        sutVM = HomeVM(postManager: mockPostManager, defsManager: mockDefsManager)
        mockHomeVC = MockHomeVC(viewModel: sutVM)
        mockTableView = .init()
        mockTableView.register(StoryTVCell.self,
                           forCellReuseIdentifier: StoryTVCell.identifier)
        mockTableView.register(HomeTVCell.self,
                           forCellReuseIdentifier: HomeTVCell.identifier)
    }
    
    override func tearDownWithError() throws {
        mockPostManager = nil
        mockDefsManager = nil
        sutVM = nil
        mockHomeVC = nil
        mockTableView = nil
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
    
    func testDS_numberOfSections() throws {
        let sectionCount = sutVM.dataSource.numberOfSections(in: mockTableView)
        XCTAssertEqual(sectionCount, HomeCase.allCases.count)
    }
    
    func testDS_numberOfRowsInSectionStory() throws {
        let currentSection = 0
        let rowsCount = sutVM.dataSource.tableView(mockTableView, numberOfRowsInSection: currentSection)
        
        XCTAssertEqual(rowsCount, 1)
    }
    
    func testDS_numberOfRowsInSectionPost() throws {
        let currentSection = 1
        let rowsCount = sutVM.dataSource.tableView(mockTableView, numberOfRowsInSection: currentSection)
        
        XCTAssertEqual(rowsCount, sutVM.dataSource.models.count)
    }
    
    func testDS_cellForRowAtStory() throws {
        let indexPath = IndexPath(row: 0, section: 0)
        let storyCell = sutVM.dataSource.tableView(mockTableView, cellForRowAt: indexPath)
        
        XCTAssertTrue(storyCell is StoryTVCell)
    }
    
    func testDS_cellForRowAtPost() throws {
        let indexPath = IndexPath(row: 0, section: 1)
        sutVM.dataSource.models = [.init()]
        let homeTVCell = sutVM.dataSource.tableView(mockTableView, cellForRowAt: indexPath)
        
        XCTAssertTrue(homeTVCell is HomeTVCell)
    }
    
    func testDS_heightForRowAtStory() throws {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let heightForRowAt = sutVM.dataSource.tableView(mockTableView, heightForRowAt: indexPath)
        XCTAssertEqual(heightForRowAt, 100)
    }
    
    func testDS_heightForRowAtPost() throws {
        let indexPath = IndexPath.init(row: 0, section: 1)
        let heightForRowAt = sutVM.dataSource.tableView(mockTableView, heightForRowAt: indexPath)
        XCTAssertEqual(heightForRowAt, 570)
    }
    
    func testDS_setUID() {
        let mockUID = "mockUID"
        sutVM.dataSource.setUID(uid: mockUID)
        
        XCTAssertEqual(mockHomeVC.uid, mockUID)
    }
}
