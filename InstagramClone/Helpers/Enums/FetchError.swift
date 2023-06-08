//
//  FetchError.swift
//  InstagramClone
//
//  Created by mehmet duran on 7.06.2023.
//

import Foundation

enum FetchError: Error {
    case backendError
    case noneItem
    
    var message: String {
        switch self {
            
        case .backendError:
            return "An unexpected error has occurred."
        case .noneItem:
            return "It seems your stream is empty"
        }
    }
}
