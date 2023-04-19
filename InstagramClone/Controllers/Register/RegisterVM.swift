//
//  RegisterVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 3.04.2023.
//

import UIKit
import Firebase

enum RegisterVMStateChange: StateChange {
    case showAlert(message: String)
    case registerSucces
}

class RegisterVM: StatefulVM<RegisterVMStateChange> {
    var registerModel = RegisterModel()
}

extension RegisterVM {
    
    func registerValidate() {
        let validationManager = ValidationManager.shared
        guard let name = registerModel.fullName,
              let userName = registerModel.userName,
              let email = registerModel.email,
              let phoneNumber = registerModel.phoneNumber,
              let password = registerModel.password,
              let passwordAgain = registerModel.passwordAgain else {
            emit(.showAlert(message: "alanları eksiksiz doldurunuz"))
            return
            
        }
        
        if !validationManager.validate(name: name) {
            emit(.showAlert(message: "plase check your name"))
        } else if !validationManager.validate(email: email) {
            emit(.showAlert(message: "plase check your email"))
        } else if !validationManager.validate(phone: phoneNumber) {
            emit(.showAlert(message: "plase check your phone number"))
        } else if !validationManager.validate(password: password) {
            emit(.showAlert(message: "plase check your passwprd"))
        } else if password != passwordAgain {
            emit(.showAlert(message: "passwords are not matched"))
        } else {
            register(email: email,
                     password: password,
                     userName: userName,
                     phoneNumber: phoneNumber,
                     fullName: name)
        }
    }
    
    private func register(email: String, password: String, userName: String, phoneNumber: String, fullName: String) {

        Auth.auth().createUser(withEmail: email, password: password) { [weak self]
          (result, error) in
            guard let self = self else { return }
          if error != nil {
              AlertManager.shared.showAlert(onVC: UIApplication.getTopViewController(),
                                            errorMesaage: error?.localizedDescription ?? "")
          } else {
              Defs.shared.userModel = DefsUserModel(uid: result?.user.uid,
                                                    fullName: fullName,
                                                    userName: userName,
                                                    email: email,
                                                    phoneNumber: phoneNumber)
              self.emit(.registerSucces)
          }
      }
    }
    
    private func setDisplayName(userName: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName
        changeRequest?.commitChanges()
        
    }
}
