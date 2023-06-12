//
//  EmailSignInViewController.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/16.
//

import UIKit
import FirebaseAuth

class EmailSignInViewController: UIViewController {
    
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
        label.font = UIFont.customFont(ofSize: 16, weight: .regular, fontName: "GowunDodum-Regular")
        label.textAlignment = .left
        return label
    }()
    
    private let passwordTextField: UITextField = {
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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.customFont(ofSize: 12, weight: .regular, fontName: "GowunDodum-Regular")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("계정이 없으신가요? 회원 가입하기", for: .normal)
        button.titleLabel?.font = UIFont.customFont(ofSize: 15, weight: .regular, fontName: "GowunDodum-Regular")
        button.addTarget(self, action: #selector(moveToRegisterView), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetPasswordViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("비밀번호를 잊어버리셨나요?", for: .normal)
        button.titleLabel?.font = UIFont.customFont(ofSize: 15, weight: .regular, fontName: "GowunDodum-Regular")
        button.addTarget(self, action: #selector(moveToResetPasswordView), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(image: .none, style: .plain, target: nil, action: nil)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
        // Add Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(registerViewButton)
        scrollView.addSubview(resetPasswordViewButton)

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
        loginButton.frame = CGRect(x: 16, y: passwordTextField.bottom + 50, width: 361, height: 42)
        registerViewButton.frame = CGRect(x: 16, y: loginButton.bottom + 30, width: 361, height: 42)
        resetPasswordViewButton.frame = CGRect(x: 16, y: registerViewButton.bottom, width: 361, height: 42)

        
        passwordTextField.rightView = passwordToggleButton
        passwordTextField.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        print("tapped")
        passwordTextField.isSecureTextEntry.toggle()
        let image = passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        passwordToggleButton.setImage(image, for: .normal)
        
        }
    
    @objc private func loginButtonTapped() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text, let password = passwordTextField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        //MARK: - Firebase Login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email: \(email)")
                return
            }
            
            let user = result.user
            print("Logged In User: \(user)")
            
            DispatchQueue.main.async {
                let vc = MonthlyViewController()
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .fullScreen
                
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.isAuthenticated = true
                }
                strongSelf.present(navVC, animated: true)
            }
            
        }
        
        
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "", message: "로그인을 위한 정보를 모두 입력해주세요", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "뒤로 가기", style: .cancel))
        present(alert, animated: true)
    }
    
    
    @objc private func moveToRegisterView() {
        let vc = EmailSignUpViewController()
        vc.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func moveToResetPasswordView() {
        let vc = ResetPasswordViewController()
        vc.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension EmailSignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            loginButtonTapped()
        }
        return true
    }
}
