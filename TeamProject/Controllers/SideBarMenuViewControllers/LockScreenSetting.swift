//
//  LockScreenSetting.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import SwiftUI

struct LockScreenSetting: View {
    @State private var isOn = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                NavigationLink(destination: PinLockScreen(), isActive: $isOn) {
                    Text("암호 잠금")
                        .foregroundColor(.black)
                        .font(.system(size: 14))

                    Toggle("", isOn: $isOn)
                        .toggleStyle(SwitchToggleStyle(tint: Color.black))
                        .navigationBarHidden(true)
                }
                

                
                Text("ⓘ 암호를 분실하면 찾을 수 없습니다.")
                    .foregroundColor(.red)
                    .font(.system(size: 13))
                
                Toggle("Face ID", isOn: $isOn)
                    .toggleStyle(SwitchToggleStyle(tint: Color.black))
                    .font(.system(size: 14))
                
                Spacer()

            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .padding([.leading, .trailing])
            .padding(.top, 20)
            
        }
    }
}

struct LockScreenSetting_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenSetting()
    }
}
