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
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 40,
                                        height: 40))
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = view.frame.width / 2
        return view
    }()
    
    // 두번째 암호 표시 UI
    lazy var secondPasswordCircleView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 40,
                                        height: 40))
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = view.frame.width / 2
        return view
    }()
    
    // 세번째 암호 표시 UI
    lazy var thirdPasswordCircleView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 40,
                                        height: 40))
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = view.frame.width / 2
        return view
    }()
    
    // 네번째 암호 표시 UI
    lazy var fourthPasswordCircleView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 40,
                                        height: 40))
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = view.frame.width / 2
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
        print(stackView.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutoLayout() {
        backgroundColor = .white

        addSubview(passwordGuideLabel)
        addSubview(firstPasswordCircleView)
        addSubview(secondPasswordCircleView)
        addSubview(thirdPasswordCircleView)
        addSubview(fourthPasswordCircleView)
        addSubview(stackView)
        addSubview(passwordTextField)
        
        passwordGuideLabel.translatesAutoresizingMaskIntoConstraints = false
        firstPasswordCircleView.translatesAutoresizingMaskIntoConstraints = false
        secondPasswordCircleView.translatesAutoresizingMaskIntoConstraints = false
        thirdPasswordCircleView.translatesAutoresizingMaskIntoConstraints = false
        fourthPasswordCircleView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            passwordGuideLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordGuideLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),

            stackView.topAnchor.constraint(equalTo: passwordGuideLabel.bottomAnchor, constant: 40),
            stackView.widthAnchor.constraint(equalToConstant: 235),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
    }
    
    
}

