//
//  MemoViewController.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/24.
//

import UIKit

final class MemoViewController: UIViewController {
    
    // MARK: - Object
    
    private let memoView = MemoView()
    
    
    
    
    // MARK: - Variable
    
    private var checkTextArray: [String] = [""]
    var checkTextIndexPath = 0
    
    
    // MARK: - ViewController LifeCycle
    
    override func loadView() {
        super.loadView()
        view = memoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        //        setupAddTarget()
        setupNaviBar()
        //        setUpNotification()
        memoView.memoTableView.register(MemoCheckListTableViewCell.self, forCellReuseIdentifier: MemoCheckListTableViewCell.id)
    }
    
    
    
    // MARK: - Initial Method
    
    func setupDelegate() {
        memoView.memoTableView.dataSource = self
        //            memoView.titleTextField.delegate = self
        memoView.memoTextView.delegate = self
        memoView.memoTableView.delegate = self
    }
    //
    //    func setupAddTarget() {
    //        memoView.checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    ////        memoView.textButton.addTarget(self, action: #selector(textButtonTapped), for: .touchUpInside)
    //    }
    
    func setupNaviBar() {
        title = "2023.04.11"
        
        // (네비게이션바 설정관련) iOS버전 업데이트 되면서 바뀐 설정⭐️⭐️⭐️
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        // navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension MemoViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        if textView.text == memoView.textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = memoView.textViewPlaceHolder
            textView.textColor = .lightGray
        }
    }
    
}



// MARK: - Custom Method
//
//    @objc func checkButtonTapped(){
//        cellArrary.append(.checkList)
////        memoView.textTableView.reloadData()
//    }

//    @objc func textButtonTapped(){
//        cellArrary.append(.text)
//        print("텍스트버튼 클릭 cellArray: \(cellArrary)")
////        memoView.memoTableView.reloadData()
//    }

//    private func setUpNotification() {
//        print(#function)
//        // 키보드가 올라올 때 호출
//        NotificationCenter.default.addObserver(
//            self, selector: #selector(keyboardWillShow),
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil
//        )
//
//        // 키보드가 내려갈 때 호출
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillHide),
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil
//        )
//    }

//    //키보드 올라왔을 때 실행 되는 메서드
//    @objc func keyboardWillShow(_ sender: Notification) {
//
//        // 키보드의 높이를 구하는 코드
//            let userInfo: NSDictionary = sender.userInfo! as NSDictionary
//            let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//
//        // 프레임 높이 오토레이아웃을 키보드 높이 만큼 줄이는 코드
//        memoView.frameautoLayout.constant = -1 * keyboardHeight
//        print(memoView.frameautoLayout.constant)
//        }
//
//    // 키보드가 내려갔을 때 실행되는 메서드
//    @objc func keyboardWillHide(_ sender: Notification) {
//
//        // 프레임 높이를 원래 높이(self.bottomAnchor, constant: 0)로 돌려주는 코드
//        memoView.frameautoLayout.constant = 0
//      }
//}

// MARK: - UITableViewDataSource

extension MemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        
        return checkTextArray.count
    }
    
    // 🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳🧑‍🦳
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // cell 생성
        //        let textCell = tableView.dequeueReusableCell(withIdentifier: MemoTextTableViewCell.id, for: indexPath) as! MemoTextTableViewCell
        
        let checkCell = tableView.dequeueReusableCell(withIdentifier: MemoCheckListTableViewCell.id, for: indexPath) as! MemoCheckListTableViewCell
        
        checkCell.listTextField.text = checkTextArray[indexPath.row]
        
        checkCell.listTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        checkCell.listTextField.delegate = self
        
        return checkCell
        
        // cell 설정
        //        switch cellArrary[indexPath.row] {
        //        case .text:
        //            return textCell
        //        case .checkList:
        //            return checkCell
        //        }
        //    }
    }

    @objc func textFieldEditingChanged(_ sender: Any? ) {
        
        let textField = sender as? UITextField
        
        print(textField?.text)
        
        guard let text = textField?.text else { return }
        
        checkTextArray[checkTextIndexPath] = text
        
        print(checkTextIndexPath)
    }
}





// MARK: - UITableViewDelegate


extension MemoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        checkTextIndexPath = indexPath.row
    }
//
//    // 행 편집 기능
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    //
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//            cellArrary.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//    }
}

// MARK: - UITextViewDelegate

//extension MemoViewController: UITextViewDelegate {
//
//    //텍스트뷰 동적 높이
//    func textViewDidChange(_ textView: UITextView) {
//        // print(#function)
////        let tableView = memoView.textTableView
//
//        //높이 계산
//        let contentSize = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: .infinity))
//
//        if textView.bounds.height != contentSize.height {
//            tableView.contentOffset.y += contentSize.height - textView.bounds.height
//
//            UIView.setAnimationsEnabled(false)
//            tableView.beginUpdates()
//            tableView.endUpdates()
//            UIView.setAnimationsEnabled(true)
//        }
//    }
//}


// MARK: - UITextFieldDelegate

extension MemoViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        guard let text = textField.text else {
            return false }
        
        checkTextArray.append(text)
        checkTextArray[checkTextIndexPath + 1] = ""
        
        checkTextIndexPath += 1
        print(checkTextArray)
        memoView.memoTableView.reloadData()
        
        return true
    }
}










