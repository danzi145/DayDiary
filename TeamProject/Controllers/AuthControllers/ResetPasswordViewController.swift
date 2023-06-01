//
//  ResetPasswordViewController.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/31.
//

import UIKit
import Firebase
import FirebaseAuth

class ResetPasswordViewController: UIViewController {
    
    private var resetPasswordView: ResetPasswordView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupButtonActions()
        
    }
    
    
    //MARK: - AutoLayout
    func configureUI() {
        resetPasswordView = ResetPasswordView()
        resetPasswordView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resetPasswordView)
        
        NSLayoutConstraint.activate([
            resetPasswordView.topAnchor.constraint(equalTo: view.topAnchor),
            resetPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resetPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resetPasswordView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func setupButtonActions() {
        resetPasswordView.resetPasswordButton.addTarget(self, action: #selector(didTapResetPassword), for: .touchUpInside)

    }
    
    @objc private func didTapResetPassword() {
        print(#function)
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: resetPasswordView.emailTextField.text!) { error in
            if let error = error {
                let alert = UIAlertController(title: "에러", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "뒤로 가기", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            
            let alert = UIAlertController(title: nil, message: "인증 메일이 성공적으로 보내졌습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)

        }
    }
    
}
