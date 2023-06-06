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
}
