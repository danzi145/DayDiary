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
    
    
    // MARK: - ViewController LifeCycle
    
    override func loadView() {
        super.loadView()
        view = memoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupNaviBar()
    }
    
    
    
    // MARK: - Initial Method
    
    func setupDelegate() {
        memoView.memoTableView.dataSource = self
        memoView.titleTextField.delegate = self
        memoView.memoTextView.delegate = self
    }
    
    func setupNaviBar() {
        title = "2023.04.11"
        
        
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    
    
    // MARK: - Custom Method
    
    @objc func saveButtonTapped() {
        print("저장 클릭")
    }
    
    
    @objc func deleteButtonTapped(_ sender: UIButton ) {
        print("삭제 클릭")
        //메세지창 컨트롤러 인스턴스 생성
        let alert = UIAlertController(title: "삭제", message: "메모를 삭제 하시겠습니까?", preferredStyle: .alert)

        //메세지창 컨트롤러 버튼액션 인스턴스 생성
        let delete = UIAlertAction(title: "삭제", style: .default) { _ in
            let point = sender.convert(CGPoint.zero, to: self.memoView.memoTableView) // 버튼의 테이블뷰 위치 확인
            guard let indexPath = self.memoView.memoTableView.indexPathForRow(at: point) else { return }
            self.checkTextArray.remove(at: indexPath.row)
            self.memoView.memoTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let cancle = UIAlertAction(title: "취소", style: .default)

        //메세지창 컨트롤러 버튼액션 추가
        alert.addAction(delete)
        alert.addAction(cancle)

        //메세지창 컨트롤러에 표시
        present(alert, animated: false)
    }
}

// MARK: - UITableViewDataSource

extension MemoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return checkTextArray.count
    }
    
    // 🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let checkCell = tableView.dequeueReusableCell(withIdentifier: MemoCheckListTableViewCell.id, for: indexPath) as! MemoCheckListTableViewCell
        
        checkCell.listTextField.delegate = self
        
        checkCell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        return checkCell
        
        }
    }

// MARK: - UITextFieldDelegate

extension MemoViewController: UITextFieldDelegate {

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        guard let text = textField.text else {
            return false }
        
        print(text)
        
        checkTextArray.append(text)
        
        
        print(checkTextArray)
        
         memoView.memoTableView.reloadData()
        return true
    }
}



extension MemoViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if memoView.memoTextView.textColor == UIColor.systemGray3 {
            memoView.memoTextView.text = nil
            memoView.memoTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if memoView.memoTextView.text.isEmpty {
            memoView.memoTextView.text = "내용"
            memoView.memoTextView.textColor = .systemGray3
        }
    }
}






