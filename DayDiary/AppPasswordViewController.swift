//
//  AppPasswordViewController.swift
//  DayDiary
//
//  Created by 남현준 on 2023/04/01.
//

import UIKit

class AppPasswordViewController: UIViewController {
    
    // 옳은 비밀번호
    let passwordNum: String = "1004"
    
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
    
    // 뒤로가기 버튼
    private let backBtn: UIButton = {
         let button = UIButton()
         button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
         button.tintColor = UIColor.black
         button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
         return button
     }()
    
    // MARK: - 중단
    // 중단 안내 레이블
    private lazy var passwordGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "원하는 비밀번호 4자리를 입력해 주세요"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    // 암호 UI
    private lazy var firstPasswordCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var secondPasswordCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var thirdPasswordCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var fourthPasswordCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    // 비밀번호 UI(회색 Circle view)
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [firstPasswordCircleView,secondPasswordCircleView,thirdPasswordCircleView,fourthPasswordCircleView])
        st.spacing = 20
        return st
    }()
    
    // 비밀번호 텍스트 필드
    private lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.becomeFirstResponder()
        textField.isHidden = true
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAutoLayout()
        
    }
    
    func setAutoLayout() {
        view.backgroundColor = .white
        
        view.addSubview(backBtn)
        view.addSubview(appPasswordLabel)
        view.addSubview(passwordGuideLabel)
        view.addSubview(firstPasswordCircleView)
        view.addSubview(secondPasswordCircleView)
        view.addSubview(thirdPasswordCircleView)
        view.addSubview(fourthPasswordCircleView)
        view.addSubview(stackView)
        view.addSubview(passwordTextField)
        
        
        
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
            appPasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            appPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 61),
            backBtn.heightAnchor.constraint(equalToConstant: 24),
            backBtn.widthAnchor.constraint(equalToConstant: 24),
            
            passwordGuideLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordGuideLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 225),
            
//            firstPasswordCircleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 87),
//            firstPasswordCircleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 296),
            firstPasswordCircleView.widthAnchor.constraint(equalToConstant: 40),
            firstPasswordCircleView.heightAnchor.constraint(equalToConstant: 40),
            
            secondPasswordCircleView.widthAnchor.constraint(equalToConstant: 40),
            secondPasswordCircleView.heightAnchor.constraint(equalToConstant: 40),
            
            thirdPasswordCircleView.widthAnchor.constraint(equalToConstant: 40),
            thirdPasswordCircleView.heightAnchor.constraint(equalToConstant: 40),
            
            fourthPasswordCircleView.widthAnchor.constraint(equalToConstant: 40),
            fourthPasswordCircleView.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 87),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 296),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 235)
            
//            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            passwordTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        ])
        
    }

    // 비밀번호 함수
    @objc func textFieldDidChange(_ sender: UITextField) {
        
        guard let inputText = sender.text,
              inputText.count <= 4 else { return }
        
        // 메서드 호출로 간단하게 처리
        handleCircleViewUI(withInput: inputText.count)
        
        
        if inputText.count == 4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
                handleCircleViewUI(withInput: 0)
                
                passwordGuideLabel.text = (inputText != passwordNum) ? "다시 한 번 입력해 주세요." : "비밀번호 일치"
                sender.text = ""
            }
        }
    }
    
    // 뷰 백그라운드 바꾸는 메서드
    func handleCircleViewUI(withInput num: Int) {
        self.circleViews.enumerated().forEach { index, circleView in
            circleView.backgroundColor = (num > index) ? UIColor.black : #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        }
    }
    
    // 이전 화면으로 넘어가는 함수
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}