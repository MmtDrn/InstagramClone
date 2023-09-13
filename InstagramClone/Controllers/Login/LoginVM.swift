//
//  LoginVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit

enum LoginVMStateChange: StateChange {
    case showAlert(message: String)
    case logInSucces
}

class LoginVM: StatefulVM<LoginVMStateChange> {
    
    private let authManager: AuthManagerPRotocol
    
    init(authManager: AuthManagerPRotocol) {
        self.authManager = authManager
    }
    
    func login(email: String, password: String) {
        FirebaseAuthManager.shared.logIn(email: email, password: password) { [weak self] result in
            guard let self else { return }
            switch result {
                
            case .success(_):
                self.emit(.logInSucces)
            case .failure(let error):
                self.emit(.showAlert(message: error.localizedDescription))
            }
        }
    }
    
    func registerRouter() -> RegisterVC {
        let authManager = FirebaseAuthManager.shared
        let registerVM = RegisterVM(authManager: authManager)
        let registerVC = RegisterVC(registerVM: registerVM)
        
        return registerVC
    }
}
