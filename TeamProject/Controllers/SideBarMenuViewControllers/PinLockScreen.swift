//
//  PinLockScreen.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import SwiftUI

struct PinLockScreen: View {
    @State var unlocked = false
    var body: some View {
        NavigationView {
            ZStack {
                if unlocked {
                    Text("App unlocked")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.heavy)
                } else {
                    PinLockScreenView(unlocked: $unlocked)

                }
            }
//            .preferredColorScheme(unlocked ? .light : .dark)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
    }
}

struct PinLockScreen_Previews: PreviewProvider {
    static var previews: some View {
        PinLockScreen()
    }
}

//MARK: - Views

struct PinLockScreenView: View {
    @State var password = ""
    // you can change when user clicks on reset password..
    // AppStorage ==> UserDefaults..
    @AppStorage("lock_Passcode") var key  = "0000"
    @Binding var unlocked: Bool
    @State var wrongPassword = false
    let height = UIScreen.main.bounds.width

    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 0)

                Menu {

                    Label {
                        Text("Help")
                    } icon: {
                        Image(systemName: "info.circle.fill")
                    }
                    .onTapGesture {

                    }

                    Label {
                        Text("Reset Password")
                    } icon: {
                        Image(systemName: "key.fill")
                    }
                    .onTapGesture {

                    }


                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.black)
                        .padding()
                }

            }
            .padding(.leading)

            Text("암호 입력")
                .foregroundColor(.black)
                .font(.system(size: 20))
                .fontWeight(.heavy)
                .padding(.top, 70)

            Text("데이 다이어리 암호를 입력해 주세요.")
                .foregroundColor(.black)
                .font(.system(size: 14))
                .padding(.top, 20)

            HStack(spacing: 20) {
                // Password circle view
                ForEach(0..<4, id: \.self) { index in
                    PasswordView(index: index, password: $password)
                }
            }
            // for smaller size iphones
            .padding(.top, height < 750 ? 20 : 30)

            // Keypad...

            Spacer(minLength: 0)

            Text(wrongPassword ? "암호가 일치하지 않습니다. \n      다시 시도해 주세요." : "")
                .foregroundColor(.red)
                .font(.system(size: 14))
                .fontWeight(.medium)

            Spacer(minLength: 0)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: height < 750 ? 5 : 15) {
                // password button...
                ForEach(1...9, id: \.self) { value in
                    PasswordButton(value: "\(value)", password: $password, key: $key, unlocked: $unlocked, wrongPassword: $wrongPassword)
                }
                PasswordButton(value: "취소", password: $password, key: $key, unlocked: $unlocked, wrongPassword: $wrongPassword)
                PasswordButton(value: "0", password: $password, key: $key, unlocked: $unlocked, wrongPassword: $wrongPassword)
                PasswordButton(value: "delete.fill", password: $password, key: $key, unlocked: $unlocked, wrongPassword: $wrongPassword)
            }
            .padding(.bottom)

        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct PasswordView: View {
    var index: Int
    @Binding var password: String

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 25, height: 25)

            if password.count > index {
                Circle()
                    .fill(Color.black)
                    .frame(width: 25, height: 25)
            }
        }
    }
}

struct PasswordButton: View {
    var value: String
    @Binding var password: String
    @Binding var key: String
    @Binding var unlocked: Bool
    @Binding var wrongPassword: Bool
    @Environment(\.dismiss) private var dismiss

    

    var body: some View {
        Button {
            if value == "취소" {
                dismiss()
            } else {
                setPassword()
            }
        } label: {
            VStack {
                if value == "취소" {
                    // Face ID icon
                    Text("취소")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                } else if value == "delete.fill" {
                    // Delete icon
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                } else {
                    // Number button
                    Text(value)
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            .padding()
        }
    }

    func faceIdTapped() {

    }

    func setPassword() {
        // check if backspace pressed...
        withAnimation {
            if value.count > 1 {
                if password.count != 0 {
                    password.removeLast()
                }
            } else {
                if password.count != 4 {
                    password.append(value)

                    // Delayed animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            if password.count == 4 {
                                if password == key {
                                    unlocked = true
                                } else {
                                    wrongPassword = true
                                    password.removeAll()
                                }
                            }
                        }
                    }
                }
            }

        }
    }
}


