//
//  SetPasswordViewController.swift
//  DayDiary
//
//  Created by 남현준 on 2023/04/01.
//

import UIKit


class SetPasswordViewController: UIViewController {
    
    
    
    // MARK: - 상단
    private let accountLabel: UILabel = {
         let label = UILabel()
         label.text = "비밀번호 변경"
         label.font = UIFont.systemFont(ofSize: 15)
         label.textColor = .black
         return label
     }()
    
    private let backBtn: UIButton = {
         let button = UIButton()
         button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
         button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
         return button
     }()
    
    // MARK: - 텍스트 필드 위 비밀번호 레이블
    private let currentPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 비밀번호"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let changePasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "변경할 비밀번호"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    
    
    // MARK: - 현재 비밀번호 입력하는 텍스트 필드 부분
    // 현재 비밀번호 입력하는 텍스트 필드
    private lazy var currentPasswordTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.tintColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.isSecureTextEntry = true
        textField.clearsOnBeginEditing = false
        textField.placeholder = "현재 비밀번호를 입력해 주세요"
        textField.font = .systemFont(ofSize: 15)
        textField.attributedPlaceholder = NSAttributedString(string: "현재 비밀번호를 입력해 주세요", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10.0),.foregroundColor: UIColor(#colorLiteral(red: 0.7295668721, green: 0.7580708861, blue: 0.7912309766, alpha: 1))])
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    // 현재 비밀번호 텍스트 필드 UIView 컨테이너
    private lazy var currentPasswordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 42
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.7295668721, green: 0.7580708861, blue: 0.7912309766, alpha: 1)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.addSubview(currentPasswordTextField)
        return view
    }()
    
    //MARK: - 변경할 비밀번호 첫번째 텍스트 필드 부분
    // 변경할 비밀번호 첫번째 텍스트 필드
    private lazy var firstChangePasswordTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.tintColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.isSecureTextEntry = true
        textField.clearsOnBeginEditing = false
        textField.placeholder = "특수문자를 포함해서 8자 이상 입력해 주세요"
        textField.font = .systemFont(ofSize: 15)
        textField.attributedPlaceholder = NSAttributedString(string: "특수문자를 포함해서 8자 이상 입력해 주세요", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10.0),.foregroundColor: UIColor(#colorLiteral(red: 0.7295668721, green: 0.7580708861, blue: 0.7912309766, alpha: 1))])
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    // 변경할 비밀번호 첫번째 텍스트 필드 UIView 컨테이너
    private lazy var firstChangePasswordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 42
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.7295668721, green: 0.7580708861, blue: 0.7912309766, alpha: 1)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: - 변경할 비밀번호 두번째 텍스트 필드 부분
    // 변경할 비밀번호 두번째 텍스트 필드
    private lazy var secondChangePasswordTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.tintColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.isSecureTextEntry = true
        textField.clearsOnBeginEditing = false
        textField.placeholder = "비밀번호를 한 번 더 입력해 주세요"
        textField.font = .systemFont(ofSize: 15)
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 한 번 더 입력해 주세요", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10.0),.foregroundColor: UIColor(#colorLiteral(red: 0.7295668721, green: 0.7580708861, blue: 0.7912309766, alpha: 1))])
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    // 변경할 비밀번호 두번째 텍스트 필드 UIView 컨테이너
    private lazy var secondChangePasswordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 42
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.7295668721, green: 0.7580708861, blue: 0.7912309766, alpha: 1)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    //MARK: - 버튼
    // 변경 버튼
    private let changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("변경", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.6571641564, green: 0.6571640372, blue: 0.6571640372, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.isEnabled = false
        button.layer.cornerRadius = 8
        button.addTarget(SetPasswordViewController.self, action: #selector(changeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 비밀번호 표시 버튼
    private lazy var passwordSecureButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPasswordTextField.delegate = self
        firstChangePasswordTextField.delegate = self
        secondChangePasswordTextField.delegate = self
        
        
        
        setAutoLayout()
        
    }
    
    
    func setAutoLayout() {
        view.backgroundColor = UIColor.white
        view.addSubview(backBtn)
        view.addSubview(accountLabel)
        view.addSubview(currentPasswordLabel)
        view.addSubview(currentPasswordTextFieldView)
        view.addSubview(changePasswordLabel)
        view.addSubview(firstChangePasswordTextFieldView)
        view.addSubview(secondChangePasswordTextFieldView)
        view.addSubview(changeButton)
        view.addSubview(currentPasswordTextField)
        view.addSubview(firstChangePasswordTextField)
        view.addSubview(secondChangePasswordTextField)
        view.addSubview(passwordSecureButton)
        
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        currentPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        currentPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        currentPasswordTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        changePasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        firstChangePasswordTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        firstChangePasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        secondChangePasswordTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        secondChangePasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
        
            accountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            accountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 61),
            backBtn.heightAnchor.constraint(equalToConstant: 24),
            backBtn.widthAnchor.constraint(equalToConstant: 24),
            

            
            currentPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currentPasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 186),
            
            currentPasswordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currentPasswordTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 211),
            currentPasswordTextFieldView.widthAnchor.constraint(equalToConstant: 361),
            currentPasswordTextFieldView.heightAnchor.constraint(equalToConstant: 42),
            
            currentPasswordTextField.centerXAnchor.constraint(equalTo: currentPasswordTextFieldView.centerXAnchor),
            currentPasswordTextField.centerYAnchor.constraint(equalTo: currentPasswordTextFieldView.centerYAnchor),
            currentPasswordTextField.widthAnchor.constraint(equalToConstant: 361),
            currentPasswordTextField.heightAnchor.constraint(equalToConstant: 42),
            currentPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            changePasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            changePasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 281),
            
            firstChangePasswordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            firstChangePasswordTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 306),
            firstChangePasswordTextFieldView.widthAnchor.constraint(equalToConstant: 361),
            firstChangePasswordTextFieldView.heightAnchor.constraint(equalToConstant: 42),
            
            firstChangePasswordTextField.centerXAnchor.constraint(equalTo: firstChangePasswordTextFieldView.centerXAnchor),
            firstChangePasswordTextField.centerYAnchor.constraint(equalTo: firstChangePasswordTextFieldView.centerYAnchor),
            firstChangePasswordTextField.widthAnchor.constraint(equalToConstant: 361),
            firstChangePasswordTextField.heightAnchor.constraint(equalToConstant: 42),
            firstChangePasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            
            secondChangePasswordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondChangePasswordTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 360),
            secondChangePasswordTextFieldView.widthAnchor.constraint(equalToConstant: 361),
            secondChangePasswordTextFieldView.heightAnchor.constraint(equalToConstant: 42),
            
            secondChangePasswordTextField.centerXAnchor.constraint(equalTo: secondChangePasswordTextFieldView.centerXAnchor),
            secondChangePasswordTextField.centerYAnchor.constraint(equalTo: secondChangePasswordTextFieldView.centerYAnchor),
            secondChangePasswordTextField.widthAnchor.constraint(equalToConstant: 361),
            secondChangePasswordTextField.heightAnchor.constraint(equalToConstant: 42),
            secondChangePasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            changeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            changeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 453),
            changeButton.widthAnchor.constraint(equalToConstant: 361),
            changeButton.heightAnchor.constraint(equalToConstant: 42),
            
            passwordSecureButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 341),
            passwordSecureButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 318),
            passwordSecureButton.widthAnchor.constraint(equalToConstant: 28),
            passwordSecureButton.heightAnchor.constraint(equalToConstant: 21)
        ])
        
    }
    
    @objc func passwordSecureModeSetting() {
        secondChangePasswordTextField.isSecureTextEntry.toggle()
        firstChangePasswordTextField.isSecureTextEntry.toggle()
        passwordSecureButton.isSelected.toggle()
    }
    
    // 이전 화면으로 넘어가는 함수
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // 변경 버튼 누르면 동작하는 함수
    @objc func changeButtonTapped() {
        // 서버랑 통신해서, 다음 화면으로 넘어가는 내용 구현
        print("다음 화면으로 넘어가기")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}



extension SetPasswordViewController: UITextFieldDelegate {
    
    
    // 포커스시 placeholder 텍스트 지우기
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = nil
    }
    
    // 포커스 해제시 원래 placeholder 텍스트 설정
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == currentPasswordTextField {
            textField.placeholder = "현재 비밀번호를 입력해 주세요"
        } else if textField == firstChangePasswordTextField {
            textField.placeholder = "특수문자를 포함해 8자 이상 입력해 주세요"
        } else if textField == secondChangePasswordTextField {
            textField.placeholder = "비밀번호를 한 번 더 입력해 주세요"
        }
        
    }

    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        // 공백입력불가 설정
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        // guard let 문으로 바인딩 / 조건이 하나라도 맞지않으면 버튼 비활성화 상태
        guard
            let currentPassword = currentPasswordTextField.text, !currentPassword.isEmpty,
            let firstChangePassword = firstChangePasswordTextField.text, !firstChangePassword.isEmpty,
            let secondChangePassword = secondChangePasswordTextField.text, !secondChangePassword.isEmpty
        else {
            changeButton.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
            changeButton.isEnabled = false
            return
        }
        changeButton.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0.4039215686, alpha: 1)
        changeButton.setTitleColor(.black, for: .normal)
        changeButton.isEnabled = true
    }
    
    // return버튼 누르면 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

}