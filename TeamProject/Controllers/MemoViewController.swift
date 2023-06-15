//
//  MemoViewController.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//

import UIKit


final class MemoViewController: UIViewController {
    
    // MARK: - Object
    
    private let memoView = MemoView()
    
    // MARK: - Variable
    
    private var checkTextArray: [String] = [""]
    
    var date: String?
//    var memoManager = MemoManager.shared
    
    // MARK: - ViewController LifeCycle
    
    override func loadView() {
        super.loadView()
        view = memoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupNaviBar()
//        setupAddTarget()
    }
    
    
    
    // MARK: - Initial Method
    
    func setupDelegate() {
        
        memoView.getTitleTextField().delegate = self
        memoView.getMemoTextView().delegate = self
    }
    
    func setupNaviBar() {
        title = date
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.6571641564, green: 0.6571640372, blue: 0.6571640372, alpha: 1)]
        // 네비게이션 백 버튼
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.isHidden = false
        
        
        let saveButton = UIBarButtonItem(
            image: UIImage(systemName: "folder"), style: .plain, target: self, action: #selector(self.saveButtonTapped))

        let checkChangeButton = UIBarButtonItem(image: UIImage(systemName: "checklist"),style: .plain, target: self,action: #selector(self.checkChagneButtonTapped))
   
         
        // 바버튼 커스텀 위치조정
//        let checkChangeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        checkChangeButton.setImage(systemName: "checklist")
//        checkChangeButton.addTarget(self, action: #selector(checkChagneButtonTapped), for: .touchUpInside)
//
//        let barbuttonItem1 = UIBarButtonItem(customView: checkChangeButton)
        
//        self.navigationItem.rightBarButtonItems = [saveButton, barbuttonItem1]
        
        self.navigationItem.rightBarButtonItems = [saveButton, checkChangeButton]
        navigationItem.rightBarButtonItem?.tintColor = .systemGray2
    }
    
    
    
    // MARK: - Custom Method
    
                              
    @objc func checkChagneButtonTapped() {
        print("checkListChangeButton이 눌렸습니다.")
        let vc = CheckListViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }

                                    

    @objc func saveButtonTapped() {
        
        if memoView.getTitleTextField().text == "" {
            let alert = UIAlertController(title: "제목 작성", message: "제목을 작성해야 저장이 가능합니다.", preferredStyle: .alert)
            //메세지창 컨트롤러 버튼액션 인스턴스 생성
            let close = UIAlertAction(title: "닫기", style: .cancel)
            //메세지창 컨트롤러 버튼액션 추가
            alert.addAction(close)
            //메세지창 컨트롤러에 표시
            present(alert, animated: false)
        } else { print("제목을 입력했습니다.") }
    }
}
    




// MARK: - UITextFieldDelegate

extension MemoViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if memoView.getTitleTextField().text != "" {
            navigationItem.rightBarButtonItem?.tintColor = .black
        } else {
            navigationItem.rightBarButtonItem?.tintColor = .systemGray2
        }
    }
}



extension MemoViewController: UITextViewDelegate {
    
    // 텍스트 편집이 시작
    func textViewDidBeginEditing(_ textView: UITextView) {
        if memoView.getMemoTextView().textColor == UIColor.systemGray3 {
            memoView.getMemoTextView().text = nil
            memoView.getMemoTextView().textColor = UIColor.black
        }
    }
    // 텍스트 편집 종료
    func textViewDidEndEditing(_ textView: UITextView) {
        if memoView.getMemoTextView().text.isEmpty {
            memoView.getMemoTextView().text = "내용"
            memoView.getMemoTextView().textColor = .systemGray3
        }
    }
}




