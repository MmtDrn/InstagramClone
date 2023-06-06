//
//  AlertManager.swift
//  InstagramClone
//
//  Created by mehmet duran on 4.04.2023.
//

import UIKit

class AlertManager {
    
    static var shared = AlertManager()
    private init() { }
    
    func showAlert(onVC: UIViewController?, type: AlertType,
                   firstActionCompletion: CompletionHandler? = nil,
                   secondActionCompletion: CompletionHandler? = nil) {
        
        switch type {
        case .justMessage(let message):
            let alertVC = AlertVC(alertType: .justMessage(message: message))
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            onVC?.present(alertVC, animated: true)
        case .doubleButton(let message, let firstButtonTitle, let secondButtonTitle):
            let alertVC = AlertVC(alertType: .doubleButton(message: message,
                                                           firstButtonTitle: firstButtonTitle,
                                                           secondButtonTitle: secondButtonTitle),
                                  firstActionCompletion: firstActionCompletion,
                                  secondActionCompletion: secondActionCompletion)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            onVC?.present(alertVC, animated: true)
        }
        
        
       
    }
}
