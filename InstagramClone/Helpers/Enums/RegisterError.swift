//
//  RegisterError.swift
//  InstagramClone
//
//  Created by mehmet duran on 2.06.2023.
//

import Foundation

enum RegisterError: Error {
    case missinField
    case name
    case email
    case phoneNumber
    case password
    case matchPasswords
    case backend
    case setUserData
    
    var errorMessage: String {
        switch self {
        case .missinField:
            return "Please fill in the missing fields"
        case .name:
            return "Please check your name"
        case .email:
            return "Please check your email"
        case .phoneNumber:
            return "Please check your phone number"
        case .password:
            return "Please check your password"
        case .matchPasswords:
            return "Passwords are not matched"
        case .backend:
            return "An error occurred. Please try again"
        case .setUserData:
            return ""
        }
    }
}
