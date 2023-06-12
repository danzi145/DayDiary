//
//  ManageAccountSetting.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import SwiftUI
import FirebaseAuth

struct ManageAccountSetting: View {

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Text("이메일")
                        .font(.system(size: 14))
                    
                    Spacer()
                    
                    Text("jen.kim29 @gmail.com")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding()
                
                HStack {
                    Text("비밀번호 변경")
                        .font(.system(size: 14))

                    
                    Spacer()
                    
                    Button {
                        print("비밀번호 변경 tapped")
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
                .foregroundColor(.black)
                .padding()
                
                Button {
                    print("로그아웃 tapped")
                    logoutTapped()
                } label: {
                    Text("로그아웃")
                        .foregroundColor(.black)
                        .font(.system(size: 14))
                    
                    Spacer()
                }
                .padding()
                
                Button {
                    print("앱 탈퇴 tapped")
                } label: {
                    Text("앱 탈퇴")
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                    
                    Spacer()
                }
                .padding()
                
                Spacer()

            }
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 20)
        }
    }
    
    private func logoutTapped() {
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
}

struct ManageAccountSetting_Previews: PreviewProvider {
    static var previews: some View {
        ManageAccountSetting()
    }
}
