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

class MultiAuthViewController: UIViewController {
    
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
    /// 카카오 로그인 버튼
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "kakaoButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(kakaoLoginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var kakaoAuthVM: KakaoAuth = { KakaoAuth() }()
    
    /// 구글 로그인 버튼
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "googleButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(googleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    /// 애플 로그인 버튼
    private lazy var appleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "appleButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(appleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    /// 이메일 로그인 버튼
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
    //MARK: - 이메일 로그인
    @objc private func emailLoginTapped() {
        let rootVC = EmailSignInViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        present(navVC, animated: true)
//        let vc = EmailLoginViewController()
//        vc.title = ""
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func exploreWithoutAcct() {
        let rootVC = MonthlyViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    //MARK: - 카카오 로그인
    @objc private func kakaoLoginTapped() {
        print(#function)
        kakaoAuthVM.handleKakaoLogin()
    }
    
    
    //MARK: - 구글 로그인
    
    @objc private func googleLoginTapped() {
        // 구글 인증
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
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
                    let vc = MonthlyViewController()
                    vc.title = ""
                    self?.navigationController?.pushViewController(vc, animated: true)
                    self?.present(vc, animated: true)
//                    DatabaseManager.shared.insertUser(with: DayDiaryAppUser(emailAddress: idToken))
//                    strongSelf.navigationController?.dismiss(animated: true)
                    
                }
            }
        }
    
    //MARK: - 애플 로그인 - Firebase 연결
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    @available(iOS 13, *)
    @objc func appleLoginTapped() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }


        
}


//MARK: - 애플 로그인 extensions
///https://doitduri.tistory.com/66?category=976652
@available(iOS 13.0, *)
extension MultiAuthViewController: ASAuthorizationControllerDelegate {

  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      guard let nonce = currentNonce else {
        fatalError("Invalid state: A login callback was received, but no login request was sent.")
      }
      guard let appleIDToken = appleIDCredential.identityToken else {
        print("Unable to fetch identity token")
        return
      }
      guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
        return
      }
      // Initialize a Firebase credential, including the user's full name.
      let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                        rawNonce: nonce,
                                                        fullName: appleIDCredential.fullName)
      // Sign in with Firebase.
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            // Handle error..
            let firstName = appleIDCredential.fullName?.givenName
            let lastName = appleIDCredential.fullName?.familyName
            let email = appleIDCredential.email
            
            // Store it in the database.
            self?.hasAccount(firstName: firstName, lastName: lastName, email: email)
        }
    }
  }

    func hasAccount(firstName: String?, lastName: String?, email: String?) {
        // Check if has account when we have Firebase Firestore setup
        guard let _ = Auth.auth().currentUser?.uid else { return }
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // 핸들링 에러
    print("Sign in with Apple errored: \(error)")
      let alert = UIAlertController(title: "에러", message: "로그인을 할 수 없습니다", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default))
      present(alert, animated: true)
  }

}

extension MultiAuthViewController: ASAuthorizationControllerPresentationContextProviding {
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


