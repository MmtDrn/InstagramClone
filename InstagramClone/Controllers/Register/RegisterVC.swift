//
//  RegisterVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 3.04.2023.
//

import UIKit

class RegisterVC: BaseViewController {
    
    private lazy var viewModel = RegisterVM()
    
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
    
    private lazy var nameTextField: BaseTextField = {
        let textField = BaseTextField(placeholder: "Full name",
                                      textAlignment: .left,
                                      textColor: .black,
                                      font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                                      opacity: 0.5,
                                      cornerRadius: CGFloat.dHeight * (10/812))
        
        textField.textFieldDidEndEditing = { [weak self] textField, text in
            self?.viewModel.registerModel.fullName = text
        }
        
        return textField
    }()
    
    private lazy var userNameTextField: BaseTextField = {
        let textField = BaseTextField(placeholder: "User name",
                                      textAlignment: .left,
                                      textColor: .black,
                                      font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                                      opacity: 0.5,
                                      cornerRadius: CGFloat.dHeight * (10/812))
        
        textField.textFieldDidEndEditing = { [weak self] textField, text in
            self?.viewModel.registerModel.userName = text
        }
        
        return textField
    }()
    
    private lazy var emailTextField: BaseTextField = {
        let textField = BaseTextField(placeholder: "Email",
                                      textAlignment: .left,
                                      textType: .emailAddress,
                                      textColor: .black,
                                      font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                                      opacity: 0.5,
                                      cornerRadius: CGFloat.dHeight * (10/812))
        
        textField.textFieldDidEndEditing = { [weak self] textField, text in
            self?.viewModel.registerModel.email = text
        }
        
        return textField
    }()
    
    private lazy var phoneNumberTextField: BaseTextField = {
        let textField = BaseTextField(placeholder: "Phone number",
                                      textAlignment: .left,
                                      textType: .phoneNumber,
                                      textColor: .black,
                                      font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                                      opacity: 0.5,
                                      cornerRadius: CGFloat.dHeight * (10/812))
        
        textField.textFieldDidEndEditing = { [weak self] textField, text in
            self?.viewModel.registerModel.phoneNumber = text
        }
        
        return textField
    }()
    
    private lazy var passwordTextField: BaseTextField = {
        let textField = BaseTextField(placeholder: "Password",
                                      textAlignment: .left,
                                      textType: .password,
                                      textColor: .black,
                                      font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                                      opacity: 0.5,
                                      cornerRadius: CGFloat.dHeight * (10/812))
        
        textField.textContentType = .oneTimeCode
        textField.textFieldDidEndEditing = { [weak self] textField, text in
            self?.viewModel.registerModel.password = text
        }
        
        return textField
    }()
    
    private lazy var passwordAgainTextField: BaseTextField = {
        let textField = BaseTextField(placeholder: "Password again",
                                      textAlignment: .left,
                                      textType: .password,
                                      textColor: .black,
                                      font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                                      opacity: 0.5,
                                      cornerRadius: CGFloat.dHeight * (10/812))
        
        textField.textFieldDidEndEditing = { [weak self] textField, text in
            self?.viewModel.registerModel.passwordAgain = text
        }
        
        return textField
    }()
    
    private lazy var textFieldStackView: BaseStackView = {
        let stackView = BaseStackView(arrangedSubviews: [nameTextField,
                                                         userNameTextField,
                                                         emailTextField,
                                                         phoneNumberTextField,
                                                         passwordTextField,
                                                         passwordAgainTextField],
                                      axis: .vertical,
                                      alignment: .fill,
                                      distribution: .fillEqually,
                                      spacing: 12)
        
        return stackView
    }()
    
    private lazy var signInButton: BaseButton = {
        let button = BaseButton(title: "Sign up",
                                titleColor: .white,
                                titleFont: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                                borderWidth: 1,
                                borderColor: .white,
                                cornerRadius: CGFloat.dHeight * (10/812))
        
        button.addTarget(self, action: #selector(sigInButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var toSignInView: LoginRegisterSubView = {
        let view = LoginRegisterSubView(title: "Already have an account?",
                                        subTitle: "Log in")
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toLoginViewAction))
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(backGroundImageview)
        view.addSubview(titleImage)
        view.addSubview(textFieldStackView)
        view.addSubview(signInButton)
        view.addSubview(toSignInView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        backGroundImageview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleImage.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(CGFloat.dHeight * (35/812))
            make.centerX.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * (80/812))
            make.width.equalTo(CGFloat.dHeight * (200/812))
        }
        
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(titleImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(CGFloat.dHeight * (48/812))
            make.height.equalTo(CGFloat.dHeight * (300/812))
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(CGFloat.dHeight * (24/812))
            make.leading.trailing.equalToSuperview().inset(CGFloat.dHeight * (48/812))
            make.height.equalTo(CGFloat.dHeight * (40/812))
        }
        
        toSignInView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(-2)
            make.height.equalTo(CGFloat.dHeight * (70/812))
        }
    }

    override func observeViewModel() {
        super.observeViewModel()
        
        viewModel.subscribe { [weak self] state in
            guard let self = self else { return }
            switch state {
                
            case .showAlert(let message):
                AlertManager.shared.showAlert(onVC: self,
                                              type: .justMessage(message: message))
            case .registerSucces:
                let vc = UINavigationController(rootViewController: TabbarVC())
                self.presentNavigate(to: vc)
            }
        }
    }
}

extension RegisterVC {
    
    @objc private func sigInButtonAction() {
        viewModel.register()
    }
    
    @objc private func toLoginViewAction() {
        dismiss(animated: true)
    }
}
