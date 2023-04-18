//
//  LoginViewController.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/04/17.
//

import Foundation


import UIKit
import Firebase
import GoogleSignIn
import Combine
import AuthenticationServices

class LoginViewController: UIViewController {
    
    var subscriptions = Set<AnyCancellable>()
    
    
    //MARK: - 데이 다이어리 로고 이미지
    private let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    //MARK: - 로그인 버튼 모음
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "kakaoButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(kakaoLoginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var kakaoAuthVM: KakaoAuthViewModel = { KakaoAuthViewModel() }()
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "googleButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(googleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var appleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "appleButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(appleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "emailButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(emailLoginTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - 로그인 없이 구경하기 버튼
    private lazy var exploreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인 없이 구경하기 >", for: .normal)
        button.titleLabel?.font = UIFont.customFont(ofSize: 16, weight: .regular, fontName: "GowunDodum-Regular")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(exploreWithoutAcct), for: .touchUpInside)
        return button
    }()
    
    

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setBindings()
    }
    
    
    //MARK: - AutoLayout
    func configureUI() {
        title = ""
        view.backgroundColor = .white
        
        view.addSubview(logoImage)
        
        let stack = UIStackView(arrangedSubviews: [kakaoLoginButton, googleLoginButton, appleLoginButton, emailLoginButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        
        view.addSubview(stack)
        
        view.addSubview(exploreButton)
        
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            logoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -480),
            
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 180),
            
            exploreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exploreButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 50)
            
        ])
        
    }
    
    @objc private func emailLoginTapped() {
        let vc = EmailLoginViewController()
        vc.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func exploreWithoutAcct() {
        
    }
    
    //MARK: - Kakao Sign-In
    @objc private func kakaoLoginTapped() {
        print(#function)
        kakaoAuthVM.kakaoLogin()
    }
    
    
    //MARK: - Google Sign-In
    /// https://jrepository.tistory.com/119
    @objc private func googleLoginTapped() {
        // 구글 인증
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        // Create Google Sign In configuration object
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            guard error == nil else { return }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
//            DatabaseManager.shared.userExists(with: idToken) { [weak self] exists in
//                guard let strongSelf = self else { return }
//                guard !exists else {
//                    // User already exists
//                    return
//                }
                // 사용자 정보 등록
                Auth.auth().signIn(with: credential) { authResult, error in
                    //사용자 등록 후 처리해야할 코드
                    guard authResult != nil, error == nil else {
                        print("Failed to log in with Google credential")
                        return
                    }
                    print("Successfully signed in with Google credential")
                    // If sign in succeed, display the app's main content view.
                    let vc = ViewController()
                    vc.title = ""
                    self.navigationController?.pushViewController(vc, animated: true)
//                    DatabaseManager.shared.insertUser(with: DayDiaryAppUser(emailAddress: idToken))
//                    strongSelf.navigationController?.dismiss(animated: true)
                    
                }
            }
        }
    
    //MARK: - Apple Sign-in
    @objc func appleLoginTapped() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}


//MARK: - ViewModel Binding
extension LoginViewController {
    fileprivate func setBindings() {
        self.kakaoAuthVM.$isLoggedIn.sink { [weak self] isLoggedIn in
            guard let self = self else { return }
//            self.kakaoLoginButton.currentImage = isLoggedIn ? "로그인 상태" : "로그아웃 상태"
        }
        .store(in: &subscriptions)
    }
}

//MARK: - Apple Sign-in extensions
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let firstName = credentials.fullName?.givenName
            let lastName = credentials.fullName?.familyName
            let email = credentials.email
            break
            
        default:
            break
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    
}

// Firebase LogOut
//let firebaseAuth = Auth.auth()
//do {
//    try firebaseAuth.signOut()
//} catch let signOutError as NSError {
//    print("로그아웃 Error발생:", signOutError)
//}
