//
//  EmailSignInViewController.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/16.
//

import UIKit
import FirebaseAuth

class EmailSignInViewController: UIViewController {
    
    private var emailSignInView: EmailSignInView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(image: .none, style: .plain, target: nil, action: nil)
        
        configureUI()
        setupButtonActions()
        
        emailSignInView.emailTextField.delegate = self
        emailSignInView.passwordTextField.delegate = self
    }
    
    
    //MARK: - AutoLayout
    func configureUI() {
        emailSignInView = EmailSignInView()
        emailSignInView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailSignInView)
        
        NSLayoutConstraint.activate([
            emailSignInView.topAnchor.constraint(equalTo: view.topAnchor),
            emailSignInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emailSignInView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emailSignInView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupButtonActions() {
        emailSignInView.passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        emailSignInView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        emailSignInView.registerViewButton.addTarget(self, action: #selector(moveToRegisterView), for: .touchUpInside)
        emailSignInView.resetPasswordViewButton.addTarget(self, action: #selector(moveToResetPasswordView), for: .touchUpInside)
    }
    
    @objc private func togglePasswordVisibility() {
        print("tapped")
        emailSignInView.passwordTextField.isSecureTextEntry.toggle()
        let image = emailSignInView.passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        emailSignInView.passwordToggleButton.setImage(image, for: .normal)
        
        }
    
    @objc private func loginButtonTapped() {
        emailSignInView.emailTextField.resignFirstResponder()
        emailSignInView.passwordTextField.resignFirstResponder()
        
        guard let email = emailSignInView.emailTextField.text, let password = emailSignInView.passwordTextField.text,
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
        if textField == emailSignInView.emailTextField {
            emailSignInView.passwordTextField.becomeFirstResponder()
        } else if textField == emailSignInView.passwordTextField {
            loginButtonTapped()
        }
        return true
    }
}
