//
//  SettingsListView.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import UIKit

class SettingsListView: UIView {

    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        addSubview(backButton)
        
        setAutolayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutolayout() {
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }

}
