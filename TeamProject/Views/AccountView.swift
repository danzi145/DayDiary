//
//  AccountView.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//

import UIKit

class AccountView: UIView {

    //버튼 높이
    let buttonHeight: CGFloat = 32
    
    
    // MARK: - 이메일 화면 뷰

    private let emailView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8797428608, green: 0.8797428012, blue: 0.8797428608, alpha: 1)
        return view
    }()
    
    private let emailNambeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.text = "연동된 이메일"
        return label
    }()
    
    private let emailLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 2
        label.textColor = .black
        label.text = "best2team.Good@gmail.comadfasfasfasdfasdfasdfasfsadfasdfasfasfasfasdfasf"
        return label
    }()
    
    
    
    // MARK: - 비밀번호 설정, 로그아웃, 앱 탈퇴 버튼

    private let passwordSettingsButton: UIButton = {
        var button = UIButton()
        button.setTitle("앱 비밀번호 설정하기", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()
    
    private let logOutButton: UIButton = {
        var button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()
    
    private let leaveButton: UIButton = {
        var button = UIButton()
        button.setTitle("앱 탈퇴", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [passwordSettingsButton, logOutButton, leaveButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    // MARK: - 오토레이아웃

    func setAutoLayout() {
        addSubview(emailView)
        emailView.addSubview(emailNambeLabel)
        emailView.addSubview(emailLabel)
        addSubview(buttonStackView)
        
        emailView.translatesAutoresizingMaskIntoConstraints = false
        emailNambeLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordSettingsButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        leaveButton.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            emailView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            emailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            emailView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            emailView.heightAnchor.constraint(equalToConstant: 120),
        
            emailNambeLabel.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 15),
            emailNambeLabel.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 20),
            emailNambeLabel.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: emailNambeLabel.bottomAnchor, constant: 12),
            emailLabel.leadingAnchor.constraint(equalTo: emailNambeLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: emailNambeLabel.trailingAnchor),
            
            passwordSettingsButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            logOutButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            leaveButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            
            buttonStackView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 10),
            buttonStackView.leadingAnchor.constraint(equalTo: emailNambeLabel.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: emailNambeLabel.trailingAnchor),
        ])
    }
}
