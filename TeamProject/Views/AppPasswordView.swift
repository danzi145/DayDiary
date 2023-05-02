//
//  AppPasswordView.swift
//  TeamProject
//
//  Created by 남현준 on 2023/04/28.
//

import UIKit

class AppPasswordView: UIView {
    
    
    // 간단하게 다루기 위한 배열 추가
    lazy var circleViews = [firstPasswordCircleView, secondPasswordCircleView, thirdPasswordCircleView, fourthPasswordCircleView]
    
    // MARK: - 상단
    private let appPasswordLabel: UILabel = {
         let label = UILabel()
         label.text = "앱 비밀번호 설정"
         label.font = UIFont.systemFont(ofSize: 15)
         label.textColor = .black
         return label
     }()
    
    // 상단의 뒤로가기 버튼
    let backBtn: UIButton = {
         let button = UIButton()
         button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
         button.tintColor = UIColor.black
         return button
     }()
    
    // MARK: - 중단
    // 중단 안내 레이블
    lazy var passwordGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "원하는 비밀번호 4자리를 입력해 주세요"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    // 첫번째 암호 표시 UI
    lazy var firstPasswordCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = 19.2
        return view
    }()
    
    // 두번째 암호 표시 UI
    lazy var secondPasswordCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = 19.2
        return view
    }()
    
    // 세번째 암호 표시 UI
    lazy var thirdPasswordCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = 19.2
        return view
    }()
    
    // 네번째 암호 표시 UI
    lazy var fourthPasswordCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = 19.2
        return view
    }()
    
    // 4개의 암호 UIView를 묶은 스택뷰
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [firstPasswordCircleView,secondPasswordCircleView,thirdPasswordCircleView,fourthPasswordCircleView])
        st.spacing = 25
        st.distribution = .fillEqually
        return st
    }()
    
    // 비밀번호 텍스트 필드
    lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.becomeFirstResponder()
        textField.isHidden = true
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutoLayout() {
        backgroundColor = .white
        
        addSubview(backBtn)
        addSubview(appPasswordLabel)
        addSubview(passwordGuideLabel)
        addSubview(firstPasswordCircleView)
        addSubview(secondPasswordCircleView)
        addSubview(thirdPasswordCircleView)
        addSubview(fourthPasswordCircleView)
        addSubview(stackView)
        addSubview(passwordTextField)
        
        
        
        appPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        passwordGuideLabel.translatesAutoresizingMaskIntoConstraints = false
        firstPasswordCircleView.translatesAutoresizingMaskIntoConstraints = false
        secondPasswordCircleView.translatesAutoresizingMaskIntoConstraints = false
        thirdPasswordCircleView.translatesAutoresizingMaskIntoConstraints = false
        fourthPasswordCircleView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            appPasswordLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 64),
            appPasswordLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            backBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 61),
            backBtn.heightAnchor.constraint(equalToConstant: 24),
            backBtn.widthAnchor.constraint(equalToConstant: 24),
            
            passwordGuideLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordGuideLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 225),
            

            firstPasswordCircleView.widthAnchor.constraint(equalToConstant: 40),
            firstPasswordCircleView.heightAnchor.constraint(equalToConstant: 40),
            
            secondPasswordCircleView.widthAnchor.constraint(equalToConstant: 40),
            secondPasswordCircleView.heightAnchor.constraint(equalToConstant: 40),
            
            thirdPasswordCircleView.widthAnchor.constraint(equalToConstant: 40),
            thirdPasswordCircleView.heightAnchor.constraint(equalToConstant: 40),
            
            fourthPasswordCircleView.widthAnchor.constraint(equalToConstant: 40),
            fourthPasswordCircleView.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 87),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 296),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 235)
        ])
        
    }
    
    
}

