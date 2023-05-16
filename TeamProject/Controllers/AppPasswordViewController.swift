//
//  AppPasswordViewController.swift
//  TeamProject
//
//  Created by 남현준 on 2023/04/28.
//

import UIKit

class AppPasswordViewController: UIViewController {
    

    // MARK: - 비밀번호 관련
    // 앱 비밀번호 설정 관련 변수값
    var tryNum: Int = 0
    
    // 확인용 비밀번호
    var passwordNum: String = ""
    
    // 설정한 앱 비밀번호
    var realPasssword: String = ""
    

    
    // MARK: - AccountView의 인스턴스
    private let appPasswordView = AppPasswordView()
    
    override func loadView() {
        view = appPasswordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }
    
    // MARK: - 인스턴스의 속성과 연결된 addTarget함수를 모은 함수
    func setupAddTarget() {
        appPasswordView.backBtn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        appPasswordView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    
    
    // MARK: - 상단의 뒤로가기 버튼 클릭 함수 (이전 화면으로 넘어가는 함수)
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - 비밀번호 확인 함수 (미리 정해놓은 비밀번호의 값과 키패드로 입력한 값이 동일한 값인지 확인하는 함수)
    @objc func textFieldDidChange(_ sender: UITextField) {      // 텍스트필드 타입의 값을 인자로 받는 함수
        
        guard let inputText = sender.text,                      // 인자값이 있고,
              inputText.count <= 4 else { return }              // 인자값의 갯수가 4개 이하일때 바인딩
        
        // 메서드 호출로 간단하게 처리
        handleCircleViewUI(withInput: inputText.count)
        
        
        if inputText.count == 4 && tryNum == 0{                              // 키패드로 입력한 텍스트필드 값의 갯수가 4개일 경우
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in       // main쓰레드(UI작업쓰레드)에서 비동기로 0.1초후에 실행
                handleCircleViewUI(withInput: 0)               // 패스워드 뷰 컬러 함수에 인자값 0 을 넣고 실행. (뷰 컬러가 회색으로)
                appPasswordView.passwordGuideLabel.text = "다시 한 번 입력해 주세요."
                passwordNum = inputText
                print(inputText)
                sender.text = ""
                tryNum = 1
 
                }
            }
        
        if inputText.count == 4 && passwordNum != inputText && tryNum == 1{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
                handleCircleViewUI(withInput: 0)
                appPasswordView.passwordGuideLabel.text = "비밀번호가 틀립니다."
                sender.text = ""
            }
        } else if inputText.count == 4 && passwordNum == inputText && tryNum == 1{
            realPasssword = inputText
            print("realPassword : \(realPasssword)")
            dismiss(animated: true, completion: nil)
        }
 
        
    }
    
    // 패스워드 뷰 컬러 바꾸는 메서드
    func handleCircleViewUI(withInput num: Int) {
        appPasswordView.circleViews.enumerated().forEach { index, circleView in
            circleView.backgroundColor = (num > index) ? UIColor.black : #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        }
    }
}
