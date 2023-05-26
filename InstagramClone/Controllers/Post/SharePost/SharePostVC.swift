//
//  SharePostVC.swift
//  InstagramClone
//
//  Created by mehmet duran on 16.05.2023.
//

import UIKit

class SharePostVC: BaseViewController {
    
    private lazy var viewModel = SharePostVM()
    
    private lazy var imageView: BaseImageView = {
        let imageView = BaseImageView(image: nil,
                                      contentMode: .scaleAspectFit,
                                      backgroundColor: .clear)
        
        return imageView
    }()
    
    private lazy var descriptionTextView: BaseTextView = {
        let textView = BaseTextView(text: .plain("Write your description about this photo.."),
                                    font: .systemFont(ofSize: CGFloat.dHeight * (14/812), weight: .semibold),
                                    textColor: .lightGray)
        
        textView.textContainerInset = UIEdgeInsets(top: 30, left: 5, bottom: 5, right: 5)
        textView.delegate = self
                
        return textView
    }()
    
    private lazy var tagPeopleButton: BaseButton = {
        let button = BaseButton(title: "Tag people",
                                titleColor: .black,
                                titleFont: .systemFont(ofSize: CGFloat.dHeight * (16/812), weight: .semibold))
                
        return button
    }()
    
    private lazy var addLocationButton: BaseButton = {
        let button = BaseButton(title: "Add location",
                                titleColor: .black,
                                titleFont: .systemFont(ofSize: CGFloat.dHeight * (16/812), weight: .semibold))
                
        return button
    }()
    
    private lazy var addMusicButton: BaseButton = {
        let button = BaseButton(title: "Add music",
                                titleColor: .black,
                                titleFont: .systemFont(ofSize: CGFloat.dHeight * (16/812), weight: .semibold))
                
        return button
    }()
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.imageView.image = image
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar(navBarType: .post(title: "Share",
                                                rightImage: UIImage(named: "check")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal),
                                                leftImage: UIImage(named: "leftArrow")),
                              backItemHidden: true,
                              isTransparent: true,
                              backGroundColor: .white,
                              rightButtonAction: #selector(shareButtonTapped),
                              leftButtonAction: #selector(backButtonTapped))
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(imageView)
        view.addSubview(descriptionTextView)
        view.addSubview(tagPeopleButton)
        view.addSubview(addLocationButton)
        view.addSubview(addMusicButton)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(CGFloat.dHeight * (70/812))
            make.height.equalTo(CGFloat.dHeight * (100/812))
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(imageView.snp.trailing).offset(2)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(CGFloat.dHeight * (100/812))
        }
        
        tagPeopleButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(5)
        }
        
        addLocationButton.snp.makeConstraints { make in
            make.top.equalTo(tagPeopleButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(5)
        }
        
        addMusicButton.snp.makeConstraints { make in
            make.top.equalTo(addLocationButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(5)
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func shareButtonTapped() {
        guard let image = imageView.image,
        let description = descriptionTextView.text else { return }
        viewModel.sharePost(image: image, description: description)
    }
    
    override func observeViewModel() {
        super.observeViewModel()
        
        viewModel.subscribe { [weak self] state in
            guard let self = self else { return }
            switch state {
                
            case .shareSuccessful:
                self.viewModel.popToTabbarvc(on: self)
            }
        }
    }
}

extension SharePostVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write your description about this photo.." {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Write your description about this photo.."
            textView.textColor = .lightGray
        }
    }
}
