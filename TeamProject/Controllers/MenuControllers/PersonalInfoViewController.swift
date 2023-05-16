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
    
    override func loadView() {
        view = personalInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }
    
    // MARK: - 인스턴스의 속성과 연결된 addTarget함수를 모은 함수
    func setupAddTarget() {
        personalInfoView.backBtn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

   
    // MARK: - 상단의 뒤로가기 버튼 클릭 함수 (이전 화면으로 넘어가는 함수)
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}

