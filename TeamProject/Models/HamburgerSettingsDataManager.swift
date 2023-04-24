//
//  HamburgerSettingsManager.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/24.
//

import UIKit

class HamburgerSettingsDataManager {
    private var dataArray: [HamburgerSettings] = []
    
    func makeData() {
        dataArray = [
            HamburgerSettings(logoImage: UIImage(systemName: "person.circle"), settingsLabel: "계정"),
            HamburgerSettings(logoImage: UIImage(systemName: "doc.plaintext"), settingsLabel: "개인정보처리방침"),
            HamburgerSettings(logoImage: UIImage(systemName: "books.vertical"), settingsLabel: "오픈소스 라이브러리")
        ]
    }
    
    func getDataArray() -> [HamburgerSettings] {
        return dataArray
    }
}

