//
//  AppDelegate.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/03/29.
//

import UIKit
import Firebase
import GoogleSignIn
import KakaoSDKCommon
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var isAuthenticated = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let nativeAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: nativeAppKey as! String)
        
        return true
    }
    
    //MARK: - 구글, 카카오 로그인 웹뷰 열기
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // Handle Google sign in callback
        if GIDSignIn.sharedInstance.handle(url) {
            return true
            
            // Handle Kakao sign in callback
        } else if AuthApi.isKakaoTalkLoginUrl(url) {
            // Update isAuthenticated property to true
            isAuthenticated = true
            // Handle Kakao authentication
            return AuthController.handleOpenUrl(url: url)
        }
        return false
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

