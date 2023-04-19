//
//  Defs.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import Foundation

class Defs {
    
    static let shared = Defs()
    private init() { }
    
    var userModel: DefsUserModel? {
        get {
            return UserDefaultsManager.get(forKey: "userModel")
        }
        set(defsModel) {
            UserDefaultsManager.set(defsModel, forKey: "userModel")
        }
    }
}
