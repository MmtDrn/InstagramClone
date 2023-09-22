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
    private var mockCollectionView: UICollectionView!
    
    override func setUpWithError() throws {
        mockPostManager = MockPostManager()
        mockDefsManager = MockDefs()
        viewModel = .init(postManager: mockPostManager, defsManager: mockDefsManager)
        mockExploreVC = .init(viewModel: viewModel)
        
        mockCollectionView = .init(frame: .zero, collectionViewLayout: .init())
        mockCollectionView.register(ExploreCell.self, forCellWithReuseIdentifier: ExploreCell.identifier)
    }
    
    override func tearDownWithError() throws {
        mockPostManager = nil
        mockDefsManager = nil
        viewModel = nil
        mockExploreVC = nil
        mockCollectionView = nil
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
    
    func testDS_numberOfSections() throws {
        let numberOfSections = viewModel.dataSource.numberOfSections(in: mockCollectionView)
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testDS_numberOfItemsInSection() throws {
        let numberOfItemsInSection = viewModel.dataSource.collectionView(mockCollectionView, numberOfItemsInSection: 0)
        
        XCTAssertEqual(numberOfItemsInSection, viewModel.dataSource.posts.count)
    }
    
    func testDS_cellForItemAt() throws {
        viewModel.dataSource.posts = [.init()]
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = viewModel.dataSource.collectionView(mockCollectionView, cellForItemAt: indexPath)

        XCTAssertTrue(cell is ExploreCell)
    }
    
    func testDS_clickPost() {
        viewModel.dataSource.clickPost(cell: .init())
        
        XCTAssertTrue(mockExploreVC.clickPost)
    }
}
