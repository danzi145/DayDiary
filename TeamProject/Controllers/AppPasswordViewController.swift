//
//  AppPasswordViewController.swift
//  TeamProject
//
//  Created by 남현준 on 2023/04/28.
//

import UIKit

class AppPasswordViewController: UIViewController {
    
    // 옳은 비밀번호
    let passwordNum: String = "1004"
    
    
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
    @objc func textFieldDidChange(_ sender: UITextField) {
        
        guard let inputText = sender.text,
              inputText.count <= 4 else { return }
        
        // 메서드 호출로 간단하게 처리
        handleCircleViewUI(withInput: inputText.count)
        
        
        if inputText.count == 4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
                handleCircleViewUI(withInput: 0)
                
                appPasswordView.passwordGuideLabel.text = (inputText != passwordNum) ? "다시 한 번 입력해 주세요." : "비밀번호 일치"
                sender.text = ""
            }
        }
    }
    
    // 뷰 백그라운드 바꾸는 메서드
    func handleCircleViewUI(withInput num: Int) {
        appPasswordView.circleViews.enumerated().forEach { index, circleView in
            circleView.backgroundColor = (num > index) ? UIColor.black : #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
        }
    }
}
