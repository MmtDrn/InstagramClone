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
    
    func showAlert(onVC: UIViewController?, errorMesaage: String) {
        let alertVC = AlertVC(message: errorMesaage)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        
        onVC?.present(alertVC, animated: true)
    }
}
