//
//  AppleSignInModel.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/17.
//

import UIKit
import Firebase
import AuthenticationServices
import CryptoKit

class AppleSignInModel: NSObject {
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    var appleSignInCompletion: ((Bool, Error?) -> Void)?

    
    @available(iOS 13, *)
    func performAppleSignIn(completion: @escaping (Bool, Error?) -> Void) {
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
        
        // Save the completion block to be called later
        self.appleSignInCompletion = completion
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
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}



// MARK: - 애플 로그인 extensions
///https://doitduri.tistory.com/66?category=976652
// MARK: - ASAuthorizationControllerDelegate

extension AppleSignInModel: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                appleSignInCompletion?(false, nil) // Handle the error condition
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                appleSignInCompletion?(false, nil) // Handle the error condition
                return
            }
            
            // Initialize a Firebase credential, including the user's full name.
            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                          rawNonce: nonce,
                                                          fullName: appleIDCredential.fullName)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    // Handle error
                    self.appleSignInCompletion?(false, error)
                    return
                }
                // Handle successful sign-in
                self.appleSignInCompletion?(true, nil)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle sign-in error
        print("Sign in with Apple errored: \(error)")

        if let topViewController = UIApplication.shared.windows.first?.windowScene?.topPresentedViewController() {
            let alert = UIAlertController(title: "에러", message: "로그인을 할 수 없습니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            topViewController.present(alert, animated: true)
        }

        self.appleSignInCompletion?(false, error)
    }
}

extension UIWindowScene {
    func topPresentedViewController() -> UIViewController? {
        if let rootViewController = self.windows.first?.rootViewController {
            return rootViewController.topPresentedViewController()
        }
        return nil
    }
}

extension UIViewController {
    func topPresentedViewController() -> UIViewController {
        if let presentedViewController = presentedViewController {
            return presentedViewController.topPresentedViewController()
        }
        return self
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension AppleSignInModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            if let window = windowScene.windows.first {
                return window
            }
        }

        fatalError("Unable to find a presentation anchor for Apple Sign-In")
    }
}
