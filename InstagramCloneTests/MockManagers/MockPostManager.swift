//
//  MockPostManager.swift
//  InstagramCloneTests
//
//  Created by mehmet duran on 22.09.2023.
//

@testable import InstagramClone

final class MockPostManager: PostManagerProtocol {
    
    var result: ([PostModel]?, FetchError?)?
    
    func followedPosts(follwedPersons: [String], completion: @escaping ([PostModel]?, FetchError?) -> Void) {
        if let result {
            completion(result.0, result.1)
        }
    }
    
    func getAllPosts(completion: @escaping ([PostModel]?, Error?) -> Void) {
        if let result {
            completion(result.0, result.1)
        }
    }
}
