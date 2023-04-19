//
//  BaseTextField.swift
//  InstagramClone
//
//  Created by mehmet duran on 31.03.2023.
//

import UIKit

class BaseTextField: UITextField {
    
    private var textFieldType: TextFieldType?
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 35)
    var textFieldDidEndEditing : ((_ textfield: UITextField, _ text : String) -> ())?
    var textFieldDidChange : ((_ text : String) -> ())?
    
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(named: "hidePassword"), for: .normal)
        button.backgroundColor = .clear
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(showPasswordButtonAction), for: .touchUpInside)

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(textChanged(textField:)), for: .editingChanged)
    }
    
    convenience init(placeholder: String? = nil,
                     text: String? = nil,
                     textAlignment: NSTextAlignment = .natural,
                     textType: TextFieldType = .generic,
                     textColor: UIColor? = .white,
                     font: UIFont? = nil,
                     borderStyle: BorderStyle = .none,
                     backgroundColor: UIColor? = .white,
                     opacity: Float = 1,
                     tintColor: UIColor? = nil,
                     cornerRadius: CGFloat? = .zero) {
        self.init()
        
        self.placeholder = placeholder
        self.text = text
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.font = font
        self.borderStyle = borderStyle
        self.backgroundColor = backgroundColor
        self.layer.opacity = opacity
        self.tintColor = tintColor
        self.layer.cornerRadius =  cornerRadius ?? .zero
        self.setTextType(textType)
        self.delegate = self
        self.textFieldType = textType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTextType(_ type: TextFieldType) {
        isSecureTextEntry = (type == .password)
        
        switch type {
        case .emailAddress:
            keyboardType = .emailAddress
            autocorrectionType = .no
            autocapitalizationType = .none
            
            if #available(iOS 10.0, *) {
                textContentType = .emailAddress
            }
            
        case .url:
            keyboardType = .URL
            autocorrectionType = .no
            autocapitalizationType = .none
            
            if #available(iOS 10.0, *) {
                textContentType = .URL
            }
            
        case .phoneNumber:
            if #available(iOS 10.0, *) {
                keyboardType = .asciiCapableNumberPad
            } else {
                keyboardType = .numberPad
            }
            
            if #available(iOS 10.0, *) {
                textContentType = .telephoneNumber
            }
            
        case .decimal:
            keyboardType = .decimalPad
            
        case .password:
            keyboardType = .asciiCapable
            autocorrectionType = .no
            autocapitalizationType = .none
            textContentType = .oneTimeCode
            
            if #available(iOS 11.0, *) {
                textContentType = .password
            }
            
            addSubview(showPasswordButton)
            showPasswordButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(10)
                make.height.width.equalTo(CGFloat.dHeight * (20/812))
            }
        case .generic:
            keyboardType = .asciiCapable
            autocorrectionType = .default
            autocapitalizationType = .sentences
        case .birthDate: break
        case .creditCard:
            break
        case .city:
            break
        case .expireDate:
            break
        case .cvv:
            break
        }
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    @objc private func textChanged(textField: UITextField){
        textFieldDidChange?(self.text!)
    }
    
    @objc private func showPasswordButtonAction(){
        let image = self.isSecureTextEntry ? UIImage(named: "showPassword") : UIImage(named: "hidePassword")
        self.isSecureTextEntry = !self.isSecureTextEntry
        self.showPasswordButton.setImage(image, for: .normal)
    }
}

extension BaseTextField: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textFieldDidEndEditing?(textField, textField.text!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        let format: String? = {
            switch textFieldType {
            case .phoneNumber: return "XXX XXX XXXX"
            case .birthDate: return "XX/XX/XXXX"
            case .expireDate: return "XX/XX"
            case .creditCard: return "XXXX XXXX XXXX XXXX"
            case .cvv: return "XXX"
            default: return nil
            }
        }()
        
        guard let format = format else { return true }
        
        textField.text = textField.format(with: format, phone: newString)
        
        return false
    }
}
