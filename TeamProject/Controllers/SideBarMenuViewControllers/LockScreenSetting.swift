//
//  LockScreenSetting.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import SwiftUI

struct LockScreenSetting: View {
    @State private var showPinLockScreen = false
    @State private var isOn = false
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Toggle("암호 잠금", isOn: $showPinLockScreen)
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .onChange(of: showPinLockScreen) { value in
                        if value {
                            presentPinLockScreen()
                        } else {
                            dismissPinLockScreen()
                        }
                    }
                
                Text("ⓘ 암호를 분실하면 찾을 수 없습니다.")
                    .foregroundColor(.red)
                    .font(.system(size: 13))
                
                Toggle("Face ID", isOn: $isOn)
                    .toggleStyle(SwitchToggleStyle(tint: Color.black))
                    .font(.system(size: 14))
                
                Spacer()
                
            }
            .fullScreenCover(isPresented: $showPinLockScreen) {
                PinLockScreen()
            }
            .padding([.leading, .trailing])
            .padding(.top, 20)
        }
    }
    
    private func presentPinLockScreen() {
        showPinLockScreen = true
    }
    
    private func dismissPinLockScreen() {
        showPinLockScreen = false
    }
}

struct LockScreenSetting_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenSetting()
    }
}
