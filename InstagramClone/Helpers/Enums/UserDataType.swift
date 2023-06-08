//
//  UserDataType.swift
//  InstagramClone
//
//  Created by mehmet duran on 2.06.2023.
//

import Foundation

enum UserDataType {
    case uid
    case email
    case fullName
    case phoneNumber
    case userName
    case profilImageUrl
    case followers
    case followed
    
    var path: String {
        switch self {
        case .uid:
            return "uuid"
        case .email:
            return "email"
        case .fullName:
            return "fullName"
        case .phoneNumber:
            return "phoneNumber"
        case .userName:
            return "userName"
        case .profilImageUrl:
            return "profilImageURL"
        case .followers:
            return "followerUID"
        case .followed:
            return "followingUID"
        }
    }
}
