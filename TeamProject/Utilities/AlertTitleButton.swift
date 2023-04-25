//
//  AlertTitleButtons.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/04/23.
//

import UIKit

// CustomAlertView에서 반복되는 코드를 줄이기 위해 생성
class AlertTitleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tintColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 19).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
