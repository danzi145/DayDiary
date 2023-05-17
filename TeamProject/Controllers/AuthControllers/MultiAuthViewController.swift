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
    
    private lazy var multiAuthView: MultiAuthView = {
        let view = MultiAuthView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // Customize the view or access its subviews if needed
        return view
    }()
        
    private lazy var kakaoAuthVM: KakaoAuth = { KakaoAuth() }()



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
                    // 
                    let navVC = UINavigationController(rootViewController: vc)
                    vc.title = ""
                    navVC.modalPresentationStyle = .fullScreen
                    self?.dismiss(animated: true) {
                        self?.present(navVC, animated: true)
                    }
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


