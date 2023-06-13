//
//  EmailSignUpViewController.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/16.
//

import UIKit
import FirebaseAuth

class EmailSignUpViewController: UIViewController {
    
    private var emailSignUpView: EmailSignUpView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(image: .none, style: .plain, target: nil, action: nil)
        
        configureUI()
        setupButtonActions()
        
        emailSignUpView.emailTextField.delegate = self
        emailSignUpView.passwordTextField.delegate = self
        emailSignUpView.passwordConfirmTextField.delegate = self
    }
    
    //MARK: - AutoLayout
    func configureUI() {
        emailSignUpView = EmailSignUpView()
        emailSignUpView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailSignUpView)
        
        NSLayoutConstraint.activate([
            emailSignUpView.topAnchor.constraint(equalTo: view.topAnchor),
            emailSignUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emailSignUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emailSignUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupButtonActions() {
        emailSignUpView.passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        emailSignUpView.passwordConfirmToggleButton.addTarget(self, action: #selector(togglePasswordConfirmVisibility), for: .touchUpInside)
        emailSignUpView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }

    
    @objc private func togglePasswordVisibility() {
        print("tapped")
        emailSignUpView.passwordTextField.isSecureTextEntry.toggle()
        let image = emailSignUpView.passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        emailSignUpView.passwordToggleButton.setImage(image, for: .normal)
        
        }
    
    @objc private func togglePasswordConfirmVisibility() {
        print("tapped")
        emailSignUpView.passwordConfirmTextField.isSecureTextEntry.toggle()
        let image = emailSignUpView.passwordConfirmTextField.isSecureTextEntry ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        emailSignUpView.passwordConfirmToggleButton.setImage(image, for: .normal)
    }
    
    @objc private func registerButtonTapped() {
        emailSignUpView.emailTextField.resignFirstResponder()
        emailSignUpView.passwordTextField.resignFirstResponder()
        emailSignUpView.passwordConfirmTextField.resignFirstResponder()
        
        guard let email = emailSignUpView.emailTextField.text,
              let password = emailSignUpView.passwordTextField.text,
              let passwordConfirm = emailSignUpView.passwordConfirmTextField.text,
              !email.isEmpty,
              !password.isEmpty,
              !passwordConfirm.isEmpty else {
            alertUserRegisterError(message: "가입 완료를 위해 모든 정보를 기입해주세요.")
            return
        }
        
        if password.count < 6 {
            alertUserRegisterError(message: "비밀번호는 최소 6자리 이상이어야 합니다.")
            return
        }
        
        if password != passwordConfirm {
            alertUserRegisterError(message: "비밀번호가 일치하지 않습니다.")
            return
        }
    
        
        //MARK: - Firebase Register
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            guard let result = authResult, error == nil else {
                print("Error creating user")
                return
            }
            let user = result.user
            print("Created user: \(user)")
            
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
    
    func alertUserRegisterError(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}


extension EmailSignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailSignUpView.emailTextField {
            emailSignUpView.passwordTextField.becomeFirstResponder()
        } else if textField == emailSignUpView.passwordTextField {
            emailSignUpView.passwordConfirmTextField.becomeFirstResponder()
        } else if textField == emailSignUpView.passwordConfirmTextField {
            registerButtonTapped()
        }
        return true
    }
}
