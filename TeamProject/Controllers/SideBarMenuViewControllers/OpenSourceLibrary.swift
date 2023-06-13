//
//  OpenSourceLibrary.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import SwiftUI

struct OpenSourceLibrary: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("• FSCalendar")
                    
                    Spacer()
                }
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding([.leading, .trailing])
            .padding(.top, 20)
            .font(.system(size: 14))
        }
    }
}

struct OpenSourceLibrary_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceLibrary()
    }
}

