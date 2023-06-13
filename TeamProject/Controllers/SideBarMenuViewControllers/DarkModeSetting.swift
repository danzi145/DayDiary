//
//  DarkModeSetting.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import SwiftUI

struct DarkModeSetting: View {
    @State private var isOn = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Toggle("다크 모드", isOn: $isOn)
                    .toggleStyle(SwitchToggleStyle(tint: Color.black))
                    .font(.system(size: 14))
                
                Toggle("시스템 설정", isOn: $isOn)
                    .toggleStyle(SwitchToggleStyle(tint: Color.black))
                    .font(.system(size: 14))
                
                Text("사용자 기기의 시스템 설정에 따라 화면이 자동으로 조정됩니다.")
                    .foregroundColor(.red)
                    .font(.system(size: 13))
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding([.leading, .trailing])
            .padding(.top, 20)
        }
    }
}

struct DarkModeSetting_Previews: PreviewProvider {
    static var previews: some View {
        DarkModeSetting()
    }
}
