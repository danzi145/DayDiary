//
//  PersonalInfoViewController.swift
//  TeamProject
//
//  Created by 남현준 on 2023/04/28.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    // MARK: - PersonalInfoView의 인스턴스
   private let personalInfoView = PersonalInfoView()
    private let headerView = MenuHeaderStackView(title: "개인정보처리방침")
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerView, personalInfoView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
//    override func loadView() {
//        view = personalInfoView
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
//        personalInfoView.backBtn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        headerView.backButton.addTarget(self,action: #selector(backButtonTapped),for: .touchUpInside)
    }

   
    // MARK: - 상단의 뒤로가기 버튼 클릭 함수 (이전 화면으로 넘어가는 함수)
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}

