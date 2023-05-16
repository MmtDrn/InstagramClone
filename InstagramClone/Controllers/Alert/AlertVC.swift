//
//  AletVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 4.04.2023.
//

import UIKit

class AlertVC: BaseViewController {
    
    private lazy var containerView: BaseView = {
        let view = BaseView(backGroundColor: .black)
        
        view.layer.opacity = 0.0
        
        return view
    }()
    
    private var alertView: AlertView?
    
    convenience init(alertType: AlertType,
                     firstActionCompletion: CompletionHandler? = nil,
                     secondActionCompletion: CompletionHandler? = nil) {
        self.init()
        
        switch alertType {
        case .justMessage(let message):
            self.alertView = AlertView(type: .justMessage(message: message))
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
        case .doubleButton(let message, let firstButtonTitle, let secondButtonTitle):
            self.alertView = AlertView(type: .doubleButton(message: message, firstButtonTitle: firstButtonTitle,
                                                           secondButtonTitle: secondButtonTitle),
                                       firstActionCompletion: firstActionCompletion,
                                       secondActionCompletion: secondActionCompletion)
            NotificationCenter.default.addObserver(self, selector: #selector(backAction), name: .alertViewDismiss, object: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: .alertViewDismiss,
                                                  object: nil)
    }
    
    override func setupViews() {
        super.setupViews()
        view.backgroundColor = .clear
        view.addSubview(containerView)
        view.addSubview(alertView!)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        containerView.frame = view.bounds
        
            alertView!.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-self.view.frame.height)
                make.height.equalTo(CGFloat.dHeight * 0.2)
                make.width.equalTo(CGFloat.dWidth * (2/3))
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
        UIView.animate(withDuration: 0.1, animations: {
            self.containerView.layer.opacity = 0.5
        }) { done in
            UIView.animate(withDuration: 0.2, animations: {
                self.alertView!.snp.updateConstraints { make in
                    make.centerY.equalToSuperview().offset(CGFloat.dHeight * (100/812))
                }
                self.view.layoutIfNeeded()
            }) { done in
                if done {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.alertView!.snp.updateConstraints { make in
                            make.centerY.equalToSuperview()
                        }
                        self.view.layoutIfNeeded()
                    })
                }
            }
        }
    }
    
    @objc private func backAction() {
        self.dismiss(animated: true)
    }
}
