//
//  SelectionAlert.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/04/04.
//

import UIKit

final class CustomAlertViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var customAlertView = CustomAlertView(date: baseDate)
    
    // 얼럿뷰의 상단에 띄울 날짜 기준 잡기
    private var baseDate: Date
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = customAlertView
    }
    
    init(baseDate: Date) {
        self.baseDate = baseDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }

    // MARK: - Actions
    
    // 버튼 밖을 터치하면, dismiss 되도록 구현
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    @objc func diaryButtonTapped() {
        print(#function)
    }
    
    @objc func noteButtonTapped() {
        print(#function)
    }
    
    @objc func lockedDiaryButtonTapped() {
        // waitingVC 사라지는 부분 부자연스러움 - 개선 필요
        let waitingVC = WaitingPopupViewController()
        waitingVC.modalPresentationStyle = .fullScreen
        present(waitingVC, animated: false)
    }
    
    @objc func plusButtonTapped() {
        print(#function)
    }
    
    // MARK: - Helpers

    private func setupAddTarget() {
        customAlertView.diaryTitleButton.addTarget(self, action: #selector(diaryButtonTapped), for: .touchUpInside)
        customAlertView.noteTitleButton.addTarget(self, action: #selector(noteButtonTapped), for: .touchUpInside)
        customAlertView.lockedDiaryTitleButton.addTarget(self, action: #selector(lockedDiaryButtonTapped), for: .touchUpInside)
        customAlertView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    

    
}

