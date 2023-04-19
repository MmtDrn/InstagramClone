//
//  LoginVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 12.04.2023.
//

import UIKit
import Firebase

enum LoginVMStateChange: StateChange {
    case showAlert(message: String)
    case logInSucces
}

class LoginVM: StatefulVM<LoginVMStateChange> {
    
    func logİn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.emit(.showAlert(message: error?.localizedDescription ?? ""))
            } else {
                self.emit(.logInSucces)
            }
        }
    }
}
