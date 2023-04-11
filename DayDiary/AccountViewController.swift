//
//  ViewController.swift
//  DayDiary
//
//  Created by 남현준 on 2023/03/24.
//

import UIKit

class AccountViewController: UIViewController {
    
   private let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "계정"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    
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
    
   private let appPasswordSettingButton: UIButton = {
        let button = UIButton()
        button.setTitle("앱 비밀번호 설정하기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(appPasswordSettingBtnTapped), for: .touchUpInside)
        return button
    }()
    
   private let passwordChangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 변경", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
       button.addTarget(self, action: #selector(passwordChangeBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let logOutButton: UIButton = {
         let button = UIButton()
         button.setTitle("로그아웃", for: .normal)
         button.setTitleColor(UIColor.black, for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
         return button
     }()
    
   private let leaveAppButton: UIButton = {
        let button = UIButton()
        button.setTitle("앱 탈퇴", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9137254902, green: 0.3019607843, blue: 0.3019607843, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(leaveAppAlert), for: .touchUpInside)
        return button
    }()
    
   private let backBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor.black
        return button
    }()
    
    private lazy var emailContainer: UIView = {
        let view = UIView()
        view.layer.backgroundColor = ( #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 0.2))
        view.addSubview(joinedEmail)
        view.addSubview(emailLabel)
        return view
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAutoLayout()
        
        
        
    }

    
    
    
    func setAutoLayout() {
        view.backgroundColor = UIColor.white
        view.addSubview(emailContainer)
        view.addSubview(accountLabel)
        view.addSubview(appPasswordSettingButton)
        view.addSubview(passwordChangeButton)
        view.addSubview(leaveAppButton)
        view.addSubview(backBtn)
        view.addSubview(logOutButton)
        
        
        emailContainer.translatesAutoresizingMaskIntoConstraints = false
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        joinedEmail.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        appPasswordSettingButton.translatesAutoresizingMaskIntoConstraints = false
        passwordChangeButton.translatesAutoresizingMaskIntoConstraints = false
        leaveAppButton.translatesAutoresizingMaskIntoConstraints = false
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            emailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            emailContainer.heightAnchor.constraint(equalToConstant: 110),
            
            accountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            accountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            joinedEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            joinedEmail.topAnchor.constraint(equalTo: view.topAnchor, constant: 127),
            
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 163),
            
            appPasswordSettingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            appPasswordSettingButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 238),
            
            passwordChangeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordChangeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 274),
            
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            logOutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 310),
            
            leaveAppButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            leaveAppButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 346),
            
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 61),
            backBtn.heightAnchor.constraint(equalToConstant: 24),
            backBtn.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        
    }
    
    @objc func appPasswordSettingBtnTapped() {
        let appPasswordSettingVC = AppPasswordViewController()
        appPasswordSettingVC.modalPresentationStyle = .fullScreen
        present(appPasswordSettingVC, animated: true, completion: nil)
    }
    
    @objc func passwordChangeBtnTapped() {
        let appPasswordSettingVC = SetPasswordViewController()
        appPasswordSettingVC.modalPresentationStyle = .fullScreen
        present(appPasswordSettingVC, animated: true, completion: nil)
    }
    
    @objc func leaveAppAlert() {
        let alert = UIAlertController(title: "앱 탈퇴", message: "탈퇴 시 모든 정보가 사라집니다. \n 탈퇴하시겠습니까?", preferredStyle: .alert)
        
        let leave = UIAlertAction(title: "탈퇴", style: .cancel) { action in
            print("탈퇴버튼이 눌렸습니다.")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .default) { action in
            print("취소버튼이 눌렸습니다.")
        }
        
        
        alert.addAction(cancel)
        alert.addAction(leave)
        
        // 실제 띄우기
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

