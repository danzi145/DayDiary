//
//  AccountViewController.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//
import UIKit
import FirebaseAuth
import GoogleSignIn


class SocialLoginAccountViewController: UIViewController {
    
    // MARK: - Object
    
    private let headerView = MenuHeaderStackView(title: "계정")
    private let accountView = SocialLoginAccountView()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerView, accountView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        setAutolayout()

        headerView.backButton.addTarget(self,
                                        action: #selector(backButtonTapped),
                                        for: .touchUpInside)
        
        accountView.passwordSettingsButton.addTarget(self,
                                                     action: #selector(appPasswordSettingsButtonTapped),
                                                     for: .touchUpInside)
        accountView.logOutButton.addTarget(self,
                                           action: #selector(logOutButtonTapped),
                                           for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func appPasswordSettingsButtonTapped() {
        let appPasswordSettingVC = AppPasswordViewController()
        appPasswordSettingVC.modalPresentationStyle = .fullScreen
        present(appPasswordSettingVC, animated: true, completion: nil)
    }
    
    @objc private func logOutButtonTapped() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            let loginVC = MultiAuthViewController()
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
               let window = sceneDelegate.window {
                window.rootViewController = loginVC
            }
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    // MARK: - Helpers
    private func setAutolayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
