//
//  RegisterVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 3.04.2023.
//

import UIKit

enum RegisterVMStateChange: StateChange {
    case showAlert(message: String)
    case registerSucces
}

class RegisterVM: StatefulVM<RegisterVMStateChange> {
    
    var registerModel = RegisterModel()
    private let authManager: AuthManagerPRotocol
    
    init(authManager: AuthManagerPRotocol) {
        self.authManager = authManager
    }
    
    public func register() {
        authManager.userRegister(model: registerModel) { [weak self] result in
            guard let self else { return }
            switch result {
                
            case .success(_):
                self.emit(.registerSucces)
            case .failure(let error):
                self.emit(.showAlert(message: error.errorMessage))
            }
        }
    }
}
