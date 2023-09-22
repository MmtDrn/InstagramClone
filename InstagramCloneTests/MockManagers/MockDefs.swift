//
//  MockDefs.swift
//  InstagramCloneTests
//
//  Created by mehmet duran on 20.09.2023.
//

@testable import InstagramClone

final class MockDefs: DefsProtocol {
    
    var mockUserModel: DefsUserModel?
    
    var userModel: InstagramClone.DefsUserModel? {
        get {
            return mockUserModel
        }
        set(newValue) {
            
        }
    }
}
