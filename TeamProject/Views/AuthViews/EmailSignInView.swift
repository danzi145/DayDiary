//
//  EmailSignInView.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import UIKit

class EmailSignInView: UIView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.font = UIFont.customFont(ofSize: 20, weight: .bold, fontName: "GowunDodum-Regular")
        label.textAlignment = .center
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = UIFont.customFont(ofSize: 16, weight: .regular, fontName: "GowunDodum-Regular")
        label.textAlignment = .left
        return label
    }()
    
    let emailTextField: UITextField = {
        let field = UITextField()
        let placeholderText = NSAttributedString(string: "이메일을 입력해주세요", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)])
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.keyboardType = .emailAddress
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.attributedPlaceholder = placeholderText
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.customFont(ofSize: 16, weight: .regular, fontName: "GowunDodum-Regular")
        label.textAlignment = .left
        return label
    }()
    
    let passwordTextField: UITextField = {
        let field = UITextField()
        let placeholderText = NSAttributedString(string: "비밀번호를 입력해주세요", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)])
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.attributedPlaceholder = placeholderText
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        field.backgroundColor = .white
        return field
    }()
    
    lazy var passwordToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .lightGray
        var configuration = UIButton.Configuration.borderless()
        configuration.imagePadding = 10

        configuration.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        configuration.buttonSize = .small
        button.configuration = configuration
        return button
    }()
    
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.customFont(ofSize: 12, weight: .regular, fontName: "GowunDodum-Regular")
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var registerViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("계정이 없으신가요? 회원 가입하기", for: .normal)
        button.titleLabel?.font = UIFont.customFont(ofSize: 15, weight: .regular, fontName: "GowunDodum-Regular")
        return button
    }()
    
    lazy var resetPasswordViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("비밀번호를 잊어버리셨나요?", for: .normal)
        button.titleLabel?.font = UIFont.customFont(ofSize: 15, weight: .regular, fontName: "GowunDodum-Regular")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetAutoLayout
    func setupViews() {
        self.backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(passwordToggleButton)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(registerViewButton)
        scrollView.addSubview(resetPasswordViewButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = bounds
        
        let size = scrollView.width / 3
        mainLabel.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
        emailLabel.frame = CGRect(x: 16, y: mainLabel.bottom + 30, width: 60, height: 25)
        emailTextField.frame = CGRect(x: 16, y: emailLabel.bottom + 6, width: 361, height: 42)
        passwordLabel.frame = CGRect(x: 16, y: emailTextField.bottom + 30, width: 60, height: 25)
        passwordTextField.frame = CGRect(x: 16, y: passwordLabel.bottom + 6, width: 361, height: 42)
        loginButton.frame = CGRect(x: 16, y: passwordTextField.bottom + 50, width: 361, height: 42)
        registerViewButton.frame = CGRect(x: 16, y: loginButton.bottom + 30, width: 361, height: 42)
        resetPasswordViewButton.frame = CGRect(x: 16, y: registerViewButton.bottom, width: 361, height: 42)

        passwordTextField.rightView = passwordToggleButton
        passwordTextField.rightViewMode = .always
        
    }
}
