//
//  DefsUserModel.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import Foundation

struct DefsUserModel: Codable {
    var uid: String?
    var fullName: String?
    var userName: String?
    var email: String?
    var phoneNumber: String?
    var profilImageURL: String?
    var followers: [String]?
    var following: [String]?
}
