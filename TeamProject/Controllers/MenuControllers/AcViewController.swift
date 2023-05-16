//
//  AcViewController.swift
//  TeamProject
//
//  Created by 남현준 on 2023/04/28.
//

import UIKit

class AcViewController: UIViewController {
    
    // MARK: - AccountView의 인스턴스
    private let accountView = AcView()
    private let headerView = MenuHeaderStackView(title: "계정")
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerView, accountView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
//    override func loadView() {
//        view = accountView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        setAutolayout()
        setupAddTarget()
    }

    // MARK: - Helpers
    
    private func setAutolayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - 인스턴스의 속성과 연결된 addTarget함수를 모은 함수
    func setupAddTarget() {
        accountView.appPasswordSettingButton.addTarget(self, action: #selector(appPasswordSettingBtnTapped), for: .touchUpInside)
        accountView.passwordChangeButton.addTarget(self, action: #selector(passwordChangeBtnTapped), for: .touchUpInside)
        accountView.leaveAppButton.addTarget(self, action: #selector(leaveAppAlert), for: .touchUpInside)
        headerView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 앱 비밀번호 설정하기 버튼 클릭 함수 (AppPasswordViewController로 넘어가는 함수)
    @objc func appPasswordSettingBtnTapped() {
        let appPasswordSettingVC = AppPasswordViewController()
        appPasswordSettingVC.modalPresentationStyle = .fullScreen
        present(appPasswordSettingVC, animated: true, completion: nil)
    }
    
    // MARK: - 비밀번호 변경 버튼 클릭 함수 (SetPasswordViewController로 넘어가는 함수)
    @objc func passwordChangeBtnTapped() {
        let setPasswordSettingVC = SetPasswordViewController()
        setPasswordSettingVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(setPasswordSettingVC, animated: true)
//        present(setPasswordSettingVC, animated: true, completion: nil)
    }
    
    // MARK: - 앱 탈퇴 버튼 클릭 함수 (탈퇴 확인 알림 함수)
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
    
    // MARK: - 상단의 뒤로가기 버튼 클릭 함수 (이전 화면으로 넘어가는 함수)
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        print("뒤로가기 버튼 눌림")
    }
    
}


