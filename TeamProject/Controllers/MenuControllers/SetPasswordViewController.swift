//
//  SetPasswordViewController.swift
//  TeamProject
//
//  Created by 남현준 on 2023/04/28.
//

import UIKit


class SetPasswordViewController: UIViewController {
    
    
    
    // MARK: - SetPasswordView의 인스턴스
    private let setPasswordView = SetPasswordView()
    private let headerView = MenuHeaderStackView(title: "비밀번호 변경")
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerView, setPasswordView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
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
        headerView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        setPasswordView.changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 변경 버튼 누르면 동작하는 함수
    @objc func changeButtonTapped() {
        // 서버랑 통신해서, 다음 화면으로 넘어가는 내용 구현
        print("다음 화면으로 넘어가기")
    }
    
    // MARK: - 상단의 뒤로가기 버튼 클릭 함수 (이전 화면으로 넘어가는 함수)
    @objc func backButtonTapped() {
        print("버튼 눌렀음")
        navigationController?.popViewController(animated: true)
    }
}
