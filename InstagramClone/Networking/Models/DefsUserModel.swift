//
//  DefsUserModel.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import Foundation

struct DefsUserModel: Codable {
    var uuid: String?
    var fullName: String?
    var userName: String?
    var email: String?
    var phoneNumber: String?
    var profilImageURL: String?
    var followerUID: [String]?
    var followingUID: [String]?
    
    mutating func setData<T>(dataType: UserDataType, data: T) {
        switch dataType {
        case .uuid:
            self.uuid = data as? String
        case .email:
            self.email = data as? String
        case .fullName:
            self.fullName = data as? String
        case .phoneNumber:
            self.phoneNumber = data as? String
        case .userName:
            self.userName = data as? String
        case .profilImageUrl:
            self.profilImageURL = data as? String
        case .followers:
            self.followerUID = data as? [String]
        case .followed:
            self.followingUID = data as? [String]
        }
    }
}
