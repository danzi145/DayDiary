//
//  GoogleSignInModel.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/17.
//

import UIKit
import Firebase
import GoogleSignIn

class GoogleSignInModel {
    static let shared = GoogleSignInModel()
    
    private init() {
        // Private initializer to enforce singleton pattern
    }
    
    // Create Google Sign In configuration object
    func configureGoogleSignIn(withClientID clientID: String) {
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    func signIn(withPresentingViewController presentingViewController: UIViewController, completion: @escaping (Bool, Error?) -> Void) {
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString else {
                    completion(false, nil)
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        completion(false, error)
                    } else {
                        completion(true, nil)
                    }
                }
            }
        }
}
