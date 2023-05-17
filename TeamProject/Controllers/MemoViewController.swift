//
//  MemoViewController.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//

import UIKit


final class MemoViewController: UIViewController {
    
    enum Save {
        case after
        case before
    }
    
    // MARK: - Object
    
    private let memoView = MemoView()
    
    
    
    
    // MARK: - Variable
    
    private var checkTextArray: [String] = [""]
    
    var saveenum: Save = .before
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
        setupAddTarget()
    }
    
    
    
    // MARK: - Initial Method
    
    func setupDelegate() {
        memoView.getMemoTableView().dataSource = self
        memoView.getTitleTextField().delegate = self
        memoView.getMemoTextView().delegate = self
    }
    
    func setupNaviBar() {
        title = date
        
        
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.6571641564, green: 0.6571640372, blue: 0.6571640372, alpha: 1)]

//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gray]
//        navigationController?.navigationBar.tintColor = .black
        

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemGray2
    }
    
    
    
    // MARK: - Custom Method
    
    func setupAddTarget() {
        memoView.getPlusCheckButton().addTarget(self, action: #selector(plusCheckButtonTapped), for: .touchUpInside)
        memoView.getTrashButton().addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
    }
    
    @objc func plusCheckButtonTapped(){
        checkTextArray.append("")
        memoView.getMemoTableView().reloadData()
        print("plusCheckButtonTapped: \(checkTextArray) ")
    }
    
    @objc func trashButtonTapped() {
        memoView.getTitleTextField().text = ""
        memoView.getMemoTextView().text = ""
        // 셀 없애기
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
        
        resizingTextView()
        saveenum = .after
        print(saveenum)
    }
    
  
    
    @objc func deleteButtonTapped(_ sender: UIButton ) {
        print("삭제 클릭")
        //메세지창 컨트롤러 인스턴스 생성
        let alert = UIAlertController(title: "삭제", message: "메모를 삭제 하시겠습니까?", preferredStyle: .alert)

        //메세지창 컨트롤러 버튼액션 인스턴스 생성
        let delete = UIAlertAction(title: "삭제", style: .default) { _ in
            let point = sender.convert(CGPoint.zero, to: self.memoView.getMemoTableView()) // 버튼의 테이블뷰 위치 확인
            guard let indexPath = self.memoView.getMemoTableView().indexPathForRow(at: point) else { return }
            self.checkTextArray.remove(at: indexPath.row)
            self.memoView.getMemoTableView().deleteRows(at: [indexPath], with: .automatic)
        }
        let cancle = UIAlertAction(title: "취소", style: .default)

        //메세지창 컨트롤러 버튼액션 추가
        alert.addAction(delete)
        alert.addAction(cancle)

        //메세지창 컨트롤러에 표시
        present(alert, animated: false)
    }
    
    
    
    func resizingTextView() {
        
        print(memoView.getMemoTextView().text!)
        
        let size = CGSize(width: view.frame.width, height: .infinity)
        
        //인자 size를 TextView에 적합한 크기(폰트 사이즈)로 계산
        let estimatedSize = memoView.getMemoTextView().sizeThatFits(size)
        
        memoView.getMemoTextView().constraints.forEach { (constraint) in
            // 높이가 300 이상일 때 300 이상으로 넘어가지 않도록 하기
            if estimatedSize.height >= 300 {
                constraint.constant = 300
            } else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
                
            }
    }
}
    
}


// MARK: - UITableViewDataSource

extension MemoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return checkTextArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let checkCell = tableView.dequeueReusableCell(withIdentifier: MemoCheckListTableViewCell.id, for: indexPath) as! MemoCheckListTableViewCell
        
        checkCell.getListTextField().delegate = self
        
        checkCell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        return checkCell
        
        }
    }

// MARK: - UITextFieldDelegate

extension MemoViewController: UITextFieldDelegate {

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        
        let point = textField.convert(CGPoint.zero, to: memoView.getMemoTableView())
        guard let indexPath = self.memoView.getMemoTableView().indexPathForRow(at: point) else { return false }

        
        checkTextArray.insert(contentsOf: [""], at: indexPath.row + 1)
        


        print("=== 체크리스트 빈배열 추가 확인용 \(checkTextArray) === ")

        memoView.getMemoTableView().reloadData()
        return true
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if memoView.getTitleTextField().text != "" {
            navigationItem.rightBarButtonItem?.tintColor = .black
        } else {
            navigationItem.rightBarButtonItem?.tintColor = .systemGray2
        }
        
        guard let text = textField.text else { return }
        
        let point = textField.convert(CGPoint.zero, to: memoView.getMemoTableView())
        guard let indexPath = self.memoView.getMemoTableView().indexPathForRow(at: point) else { return }
        
        print(" ==== indexPath : \(indexPath) ==== ")
        
        checkTextArray[indexPath.row] = text
        
        print("=== 체크리스트 배열 변경 확인용 \(checkTextArray) === ")
    
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
    
    func textViewDidChange(_ textView: UITextView) {
        print(#function)
//        resizingTextView()
        switch saveenum {
        case .after:
            resizingTextView()
        case .before:
            break
        }
    }
}





