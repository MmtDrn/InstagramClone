//
//  LoginVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 31.03.2023.
//

import UIKit
import SnapKit

 class LoginVC: BaseViewController {
    
     private var viewModel: LoginVM
    
    private lazy var backGroundImageview: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "loginBackGround"))
        
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    private lazy var titleImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "instagramName"))
        
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    private lazy var emailTextField: BaseTextField = {
        let textFeild = BaseTextField(placeholder: "Email or user name",
                                      textAlignment: .left,
                                      textType: .emailAddress,
                                      textColor: .black,
                                      font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                                      opacity: 0.5,
                                      cornerRadius: CGFloat.dHeight * (10/812))
                
        return textFeild
    }()
    
    private lazy var passwordTextField: BaseTextField = {
        let textFeild = BaseTextField(placeholder: "Password",
                                      textAlignment: .left,
                                      textType: .password,
                                      textColor: .black,
                                      font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                                      opacity: 0.5,
                                      cornerRadius: CGFloat.dHeight * (10/812))
        
        return textFeild
    }()
    
    private lazy var forgetPasswordButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Forgetten Password?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold)
        button.addTarget(self, action: #selector(forgetPasswordButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var logInButton: BaseButton = {
        let button = BaseButton(title: "Log in",
                                titleColor: .white,
                                titleFont: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                                borderWidth: 1,
                                borderColor: .white,
                                cornerRadius: CGFloat.dHeight * (10/812))
        
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var orLabel: BaseLabel = {
        let label = BaseLabel(text: "OR",
                              textColor: .white,
                              font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .regular))
        
        return label
    }()
    
    private lazy var appleButton: SocialLoginButton = {
        let button = SocialLoginButton(image: UIImage(named: "apple"),
                                      title: "Log in with Apple")
        
        button.addTarget(self, action: #selector(appleButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var googleButton: SocialLoginButton = {
       let button = SocialLoginButton(image: UIImage(named: "google"),
                                      title: "Log in with Google")
        
        button.addTarget(self, action: #selector(googleButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var toRegisterView: LoginRegisterSubView = {
        let view = LoginRegisterSubView(title: "Don't have an account?",
                                        subTitle: "Sign Up")
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toRegisterViewAction))
        view.addGestureRecognizer(gesture)
        
        return view
    }()
     
     init(viewModel: LoginVM) {
         self.viewModel = viewModel
         super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(backGroundImageview)
        view.addSubview(titleImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgetPasswordButton)
        view.addSubview(appleButton)
        view.addSubview(googleButton)
        view.addSubview(logInButton)
        view.addSubview(orLabel)
        view.addSubview(toRegisterView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        backGroundImageview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleImage.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(CGFloat.dHeight * (70/812))
            make.centerX.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * (80/812))
            make.width.equalTo(CGFloat.dHeight * (200/812))
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleImage.snp.bottom).offset(CGFloat.dHeight * (30/812))
            make.centerX.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * (40/812))
            make.width.equalTo(CGFloat.dHeight * (300/812))
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(CGFloat.dHeight * (10/812))
            make.centerX.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * (40/812))
            make.width.equalTo(CGFloat.dHeight * (300/812))
        }
        
        forgetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(CGFloat.dHeight * (4/812))
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        
        logInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(forgetPasswordButton.snp.bottom).offset(CGFloat.dHeight * (24/812))
            make.height.equalTo(CGFloat.dHeight * (40/812))
            make.width.equalTo(CGFloat.dHeight * (300/812))
        }
        
        orLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logInButton.snp.bottom).offset(CGFloat.dHeight * (40/812))
        }
        
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(CGFloat.dHeight * (20/812))
            make.centerX.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * (40/812))
            make.width.equalTo(CGFloat.dHeight * (170/812))
        }
        
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(appleButton.snp.bottom).offset(CGFloat.dHeight * (8/812))
            make.centerX.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * (40/812))
            make.width.equalTo(CGFloat.dHeight * (170/812))
        }
        
        toRegisterView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(-2)
            make.height.equalTo(CGFloat.dHeight * (70/812))
        }
    }
    
    override func observeViewModel() {
        super.observeViewModel()
         
        viewModel.subscribe { state in
            switch state {
                 
            case .showAlert(let message):
                AlertManager.shared.showAlert(onVC: self, type: .justMessage(message: message))
            case .logInSucces:
                let vc = UINavigationController(rootViewController: TabbarVC())
                self.presentNavigate(to: vc)
             }
         }
     }
}

extension LoginVC {
    
    @objc private func toRegisterViewAction() {
        let registerVC = viewModel.registerRouter()
        presentNavigate(to: registerVC)
    }
    
    @objc private func forgetPasswordButtonAction() {
        print("forgetPasswordButtonAction")
    }
    
    @objc private func appleButtonAction() {
        print("appleButtonAction")
    }
    
    @objc private func googleButtonAction() {
        print("googleButtonAction")
    }
    
    @objc private func loginButtonAction() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        viewModel.login(email: email, password: password)
    }
}
