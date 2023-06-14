//
//  NotificationSetting.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import SwiftUI

struct NotificationSetting: View {
    @State private var isOn = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Toggle("알림 받기", isOn: $isOn)
                    .toggleStyle(SwitchToggleStyle(tint: Color.black))
                    .font(.system(size: 14))
                
                Text("미래 일기 열람 날짜에 맞춰서 알림이 실행됩니다.")
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

struct NotificationSetting_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSetting()
    }
}

