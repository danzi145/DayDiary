//
//  EmailSignUpViewController.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/16.
//

import UIKit
import FirebaseAuth

class EmailSignUpViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.textAlignment = .center
        label.font = UIFont.customFont(ofSize: 20, weight: .bold, fontName: "GowunDodum-Regular")
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.textAlignment = .left
        label.font = UIFont.customFont(ofSize: 16, weight: .regular, fontName: "GowunDodum-Regular")
        return label
    }()
    
    private let emailTextField: UITextField = {
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
        label.textAlignment = .left
        label.font = UIFont.customFont(ofSize: 16, weight: .regular, fontName: "GowunDodum-Regular")
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        let placeholderText = NSAttributedString(string: "특수문자를 포함해 8자 이상 입력해주세요", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)])
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.keyboardType = .default
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
    
    private lazy var passwordToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        var configuration = UIButton.Configuration.borderless()
        configuration.imagePadding = 10

        configuration.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        configuration.buttonSize = .small
        button.configuration = configuration
        return button
    }()
    
    private let passwordConfirmTextField: UITextField = {
        let field = UITextField()
        let placeholderText = NSAttributedString(string: "비밀번호를 한번 더입력해주세요", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)])
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.attributedPlaceholder = placeholderText
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private lazy var passwordConfirmToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(togglePasswordConfirmVisibility), for: .touchUpInside)
        var configuration = UIButton.Configuration.borderless()
        configuration.imagePadding = 10

        configuration.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        configuration.buttonSize = .small
        button.configuration = configuration
        return button
    }()
    
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "mainColor")
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.customFont(ofSize: 12, weight: .regular, fontName: "GowunDodum-Regular")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(image: .none, style: .plain, target: nil, action: nil)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        
        
        // Add Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(passwordConfirmTextField)
        scrollView.addSubview(registerButton)
        
//        scrollView.isUserInteractionEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setAutoLayout()
    }
    
    func setAutoLayout() {
        scrollView.frame = view.bounds
        
        let size = scrollView.width / 3
        mainLabel.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
        emailLabel.frame = CGRect(x: 16, y: mainLabel.bottom + 30, width: 60, height: 25)
        emailTextField.frame = CGRect(x: 16, y: emailLabel.bottom + 6, width: 361, height: 42)
        passwordLabel.frame = CGRect(x: 16, y: emailTextField.bottom + 30, width: 60, height: 25)
        passwordTextField.frame = CGRect(x: 16, y: passwordLabel.bottom + 6, width: 361, height: 42)
        passwordConfirmTextField.frame = CGRect(x: 16, y: passwordTextField.bottom + 6, width: 361, height: 42)

        registerButton.frame = CGRect(x: 16, y: passwordConfirmTextField.bottom + 50, width: 361, height: 42)
        
        passwordTextField.rightView = passwordToggleButton
        passwordTextField.rightViewMode = .always
        
        passwordConfirmTextField.rightView = passwordConfirmToggleButton
        passwordConfirmTextField.rightViewMode = .always
        
        
    }
    
    @objc private func togglePasswordVisibility() {
        print("tapped")
        passwordTextField.isSecureTextEntry.toggle()
        let image = passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        passwordToggleButton.setImage(image, for: .normal)
        
        }
    
    @objc private func togglePasswordConfirmVisibility() {
        print("tapped")
        passwordConfirmTextField.isSecureTextEntry.toggle()
        let image = passwordConfirmTextField.isSecureTextEntry ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        passwordConfirmToggleButton.setImage(image, for: .normal)
    }
    
    @objc private func registerButtonTapped() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        passwordConfirmTextField.resignFirstResponder()
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let passwordConfirm = passwordConfirmTextField.text,
              !email.isEmpty,
              !password.isEmpty,
              !passwordConfirm.isEmpty,
              password.count >= 8 else {
            alertUserRegisterError()
            return
        }
        
        //MARK: - Firebase Register
        AuthDBManager.shared.userExists(with: email) { [weak self] exists in
            guard let strongSelf = self else { return }
            guard !exists else {
                // User already exists
                strongSelf.alertUserRegisterError(message: "이미 사용중인 이메일입니다.")

                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    print("Error creating user")
                    return
                }
                
                AuthDBManager.shared.insertUser(with: DayDiaryAppUser(emailAddress: email))

                strongSelf.navigationController?.dismiss(animated: true)

            }
        }
        
    }
    
    func alertUserRegisterError(message: String = "회원가입을 위한 정보를 모두 입력해주세요.") {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "뒤로 가기", style: .cancel))
        present(alert, animated: true)
    }

}


extension EmailSignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordConfirmTextField.becomeFirstResponder()
        } else if textField == passwordConfirmTextField {
            registerButtonTapped()
        }
        return true
    }
}


