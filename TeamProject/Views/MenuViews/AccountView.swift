//
//  AcView.swift
//  TeamProject
//
//  Created by 남현준 on 2023/04/28.
//

import UIKit

class AccountView: UIView {
    // MARK: - 상단
//    private let accountLabel: UILabel = {
//         let label = UILabel()
//         label.text = "계정"
//         label.font = UIFont.systemFont(ofSize: 15)
//         label.textColor = .black
//         return label
//     }()
//
//    // 상단의 뒤로가기 버튼
//    let backBtn: UIButton = {
//         let button = UIButton()
//         button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//         button.tintColor = UIColor.black
//         return button
//     }()
     
    // MARK: - 이메일 관련 레이블
     private let joinedEmail: UILabel = {
         let label = UILabel()
         label.text = "가입된 이메일"
         label.textColor = UIColor.black
         label.font = UIFont.systemFont(ofSize: 12)
         return label
     }()
     
    private let emailLabel: UILabel = {
         let label = UILabel()
         label.text = "abcdef@gmail.com"
         label.font = UIFont.systemFont(ofSize: 16)
         return label
     }()
    
    // MARK: - 가입된 이메일 주소가 들어가있는 뷰컨테이너
    private lazy var emailContainer: UIView = {
        let view = UIView()
        view.layer.backgroundColor = ( #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 0.2))
        view.addSubview(joinedEmail)
        view.addSubview(emailLabel)
        return view
    }()
     
    // MARK: - 앱 비밀번호 설정하기 버튼
     let appPasswordSettingButton: UIButton = {
         let button = UIButton()
         button.setTitle("앱 비밀번호 설정하기", for: .normal)
         button.setTitleColor(UIColor.black, for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
         return button
     }()
     
    // MARK: - 비밀번호 변경 버튼
     let passwordChangeButton: UIButton = {
         let button = UIButton()
         button.setTitle("비밀번호 변경", for: .normal)
         button.setTitleColor(UIColor.black, for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
         return button
     }()
     
    // MARK: - 로그아웃 버튼
     private let logOutButton: UIButton = {
          let button = UIButton()
          button.setTitle("로그아웃", for: .normal)
          button.setTitleColor(UIColor.black, for: .normal)
          button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
          return button
      }()
     
    // MARK: - 앱 탈퇴 버튼
     let leaveAppButton: UIButton = {
         let button = UIButton()
         button.setTitle("앱 탈퇴", for: .normal)
         button.setTitleColor(#colorLiteral(red: 0.9137254902, green: 0.3019607843, blue: 0.3019607843, alpha: 1), for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
         return button
     }()
     
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutoLayout() {
        
        addSubview(emailContainer)
//        addSubview(accountLabel)
//        addSubview(backBtn)
        addSubview(appPasswordSettingButton)
        addSubview(passwordChangeButton)
        addSubview(leaveAppButton)
        addSubview(logOutButton)
        
        
        emailContainer.translatesAutoresizingMaskIntoConstraints = false
//        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        joinedEmail.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        appPasswordSettingButton.translatesAutoresizingMaskIntoConstraints = false
        passwordChangeButton.translatesAutoresizingMaskIntoConstraints = false
        leaveAppButton.translatesAutoresizingMaskIntoConstraints = false
//        backBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            emailContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            emailContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            emailContainer.topAnchor.constraint(equalTo: self.topAnchor),
            emailContainer.heightAnchor.constraint(equalToConstant: 110),

            
            joinedEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            joinedEmail.topAnchor.constraint(equalTo: emailContainer.topAnchor, constant: 17),
            
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            emailLabel.topAnchor.constraint(equalTo: joinedEmail.topAnchor, constant: 163-127),
            
            appPasswordSettingButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 41),
            appPasswordSettingButton.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: 20),
            
            passwordChangeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 41),
            passwordChangeButton.topAnchor.constraint(equalTo: appPasswordSettingButton.bottomAnchor, constant: 20),
            
            logOutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 41),
            logOutButton.topAnchor.constraint(equalTo: passwordChangeButton.bottomAnchor, constant: 20),
            
            leaveAppButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 41),
            leaveAppButton.topAnchor.constraint(equalTo: logOutButton.bottomAnchor, constant: 20),
            
        ])
        
    }

}

