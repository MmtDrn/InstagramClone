//
//  PostManagerProtocol.swift
//  InstagramClone
//
//  Created by mehmet duran on 14.09.2023.
//

import UIKit

protocol PostManagerProtocol {
    func shareImage(shareType: ShareType,
                          image: UIImage,
                          description: String?,
                          completion: @escaping(Result<Bool,Error>) -> Void)
    func setPostData(postURL: String,
                             description: String?,
                             likeCount: String?)
    func getAllPosts(completion: @escaping([PostModel]?,Error?) -> Void)
    func getPostData(uid: String, completion: @escaping([PostModel]?,Error?) -> Void)
    func followedPosts(follwedPersons: [String], completion: @escaping([PostModel]?,FetchError?) -> Void)
}

extension PostManagerProtocol {
    
    func shareImage(shareType: ShareType,
                          image: UIImage,
                          description: String?,
                    completion: @escaping(Result<Bool,Error>) -> Void) { }
    func setPostData(postURL: String,
                     description: String?,
                     likeCount: String?) { }
    func getAllPosts(completion: @escaping([PostModel]?,Error?) -> Void) { }
    func getPostData(uid: String, completion: @escaping([PostModel]?,Error?) -> Void) { }
    func followedPosts(follwedPersons: [String], completion: @escaping([PostModel]?,FetchError?) -> Void) { }
    
}
