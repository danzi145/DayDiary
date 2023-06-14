//
//  MultiAuthViewController.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/16.
//

import UIKit
import Firebase
import GoogleSignIn
import Combine
import AuthenticationServices
import CryptoKit

class MultiAuthViewController: UIViewController{
    
    var subscriptions = Set<AnyCancellable>()
    
    let appleSignInModel = AppleSignInModel()
    
    private lazy var multiAuthView: MultiAuthView = {
        let view = MultiAuthView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // Customize the view or access its subviews if needed
        return view
    }()
        
    private lazy var kakaoAuthModel: KakaoAuthModel = { KakaoAuthModel() }()
    
    private lazy var googleSignInModel: GoogleSignInModel = {
           let model = GoogleSignInModel.shared
           model.configureGoogleSignIn(withClientID: FirebaseApp.app()?.options.clientID ?? "")
           return model
       }()


    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupButtonActions()
    }
    
    
    //MARK: - AutoLayout
    func configureUI() {
        title = ""
        view.backgroundColor = .white
        view.addSubview(multiAuthView)
        
        NSLayoutConstraint.activate([
            multiAuthView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            multiAuthView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            multiAuthView.widthAnchor.constraint(equalTo: view.widthAnchor),
            multiAuthView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    func setupButtonActions() {
        multiAuthView.emailLoginButton.addTarget(self, action: #selector(emailLoginTapped), for: .touchUpInside)
        multiAuthView.exploreButton.addTarget(self, action: #selector(exploreWithoutAcct), for: .touchUpInside)
        multiAuthView.kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginTapped), for: .touchUpInside)
        multiAuthView.googleLoginButton.addTarget(self, action: #selector(googleLoginTapped), for: .touchUpInside)
        multiAuthView.appleLoginButton.addTarget(self, action: #selector(appleLoginTapped), for: .touchUpInside)
    }

    //MARK: - 이메일 로그인
    @objc private func emailLoginTapped() {
        let rootVC = EmailSignInViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        present(navVC, animated: true)
    }
    
    @objc private func exploreWithoutAcct() {
        let rootVC = MonthlyViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            // Update the authentication status in the app delegate
            appDelegate.isAuthenticated = true
        }
        
        DispatchQueue.main.async {
            self.dismiss(animated: false) {
                self.present(navVC, animated: true)
            }
        }
    }
    
    //MARK: - 카카오 로그인
    @objc private func kakaoLoginTapped() {
        print(#function)
        kakaoAuthModel.handleKakaoLogin()
    }
    
    
    //MARK: - 구글 로그인
    @objc private func googleLoginTapped() {
        googleSignInModel.signIn(withPresentingViewController: self) { [weak self] success, error in
            if success {
                // Handle successful sign-in
                DispatchQueue.main.async {
                    let vc = MonthlyViewController()
                    let navVC = UINavigationController(rootViewController: vc)
                    navVC.modalPresentationStyle = .fullScreen
                    
                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                        // Update the authentication status in the app delegate
                        appDelegate.isAuthenticated = true
                    }
                    
                    self?.present(navVC, animated: true)
                }
            } else {
                // Handle sign-in error
                if let error = error {
                    print("Failed to log in with Google credential: \(error.localizedDescription)")
                } else {
                    print("Failed to log in with Google credential")
                }
            }
        }
    }


    
    //MARK: - 애플 로그인 - Firebase 연결
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    @objc private func appleLoginTapped() {
        if #available(iOS 13.0, *) {
            appleSignInModel.performAppleSignIn { [weak self] success, error in
                if success {
                    // Handle successful sign-in
                    let vc = MonthlyViewController()
                    let navVC = UINavigationController(rootViewController: vc)
                    navVC.modalPresentationStyle = .fullScreen
                    self?.dismiss(animated: true) {
                        self?.present(navVC, animated: true)
                    }
                } else {
                    // Handle sign-in error
                    if let error = error {
                        print("Failed to log in with Apple credential: \(error.localizedDescription)")
                    } else {
                        print("Unknown error occurred while signing in with Apple.")
                    }
                }
            }
        } else {
            print("Apple sign-in is not available on this device.")
        }
    }
}
