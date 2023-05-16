//
//  MenuHeaderStackView.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/05/15.
//

import UIKit

class MenuHeaderStackView: UIStackView {
    
    // MARK: - Properties
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.text = "계정"
        return label
    }()
    
    // MARK: - Lifecycle
    
    init(title: String) {
        super.init(frame: .zero)
        backgroundColor = .white
        titleLabel.text = title
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        addSubview(backButton)
        addSubview(titleLabel)
        
        setAutolayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    
    private func setAutolayout() {
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//            titleLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 151),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
    
}

