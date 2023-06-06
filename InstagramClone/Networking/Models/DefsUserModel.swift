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
}
