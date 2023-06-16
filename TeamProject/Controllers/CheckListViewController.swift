//
//  CheckListVController.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//

import UIKit


final class CheckListViewController: UIViewController {
    
//    enum Save {
//        case after
//        case before
//    }
//
    // MARK: - Object
    
    private let checkListView = CheckListView()
    
    // MARK: - Variable
    
    private var checkListArray: [String] = [""]
    
//    var saveenum: Save = .before
    var date: String?
//    var memoManager = MemoManager.shared
    
    
    
    // MARK: - ViewController LifeCycle
    
    override func loadView() {
        super.loadView()
        view = checkListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupNaviBar()
        setupAddTarget()
    }
    
    
    
    // MARK: - Initial Method
    
    func setupDelegate() {
        checkListView.getCheckTableView().dataSource = self
        checkListView.getTitleTextField().delegate = self
//        memoView.getMemoTextView().delegate = self
    }
    
    func setupNaviBar() {
        title = date
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.6571641564, green: 0.6571640372, blue: 0.6571640372, alpha: 1)]
        
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        let saveButton = UIBarButtonItem(
            image: UIImage(systemName: "folder"), style: .plain, target: self, action: #selector(self.saveButtonTapped))

        let memoChangeButton = UIBarButtonItem(image: UIImage(systemName: "pencil.line"),style: .plain, target: self,action: #selector(self.memoChagneButtonTapped))
        
        self.navigationItem.rightBarButtonItems = [saveButton, memoChangeButton]
   
        navigationItem.rightBarButtonItem?.tintColor = .systemGray2
    }
    
    
    
    // MARK: - Custom Method
    
    @objc func memoChagneButtonTapped() {
        print("MemoChangeButton이 눌렸습니다.")
        navigationController?.popViewController(animated: true)
        // 토글로 구현하기
        
    }
    
    
    func setupAddTarget() {
        checkListView.getPlusCheckButton().addTarget(self, action: #selector(plusCheckButtonTapped), for: .touchUpInside)
        checkListView.getTrashButton().addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func plusCheckButtonTapped(){
        checkListArray.append("")
        checkListView.getCheckTableView().reloadData()
        print("plusCheckButtonTapped: \(checkListView) ")
    }
    
    @objc func trashButtonTapped() {
        // 제목 텍스트 지우기
        checkListView.getTitleTextField().text = ""
        // 메모 내용(text) 지우기
//        memoView.getMemoTextView().text = ""
//        memoView.getMemoTextView().text = "내용"
//        memoView.getMemoTextView().textColor = .systemGray3
        // 메모 체크리스트 지우기
        checkListArray = [""]
        checkListView.getCheckTableView().reloadData()
        print(checkListView)
    }

    @objc func saveButtonTapped() {
        
        if checkListView.getTitleTextField().text == "" {
            let alert = UIAlertController(title: "제목 작성", message: "제목을 작성해야 저장이 가능합니다.", preferredStyle: .alert)
            //메세지창 컨트롤러 버튼액션 인스턴스 생성
            let close = UIAlertAction(title: "닫기", style: .cancel)
            //메세지창 컨트롤러 버튼액션 추가
            alert.addAction(close)
            //메세지창 컨트롤러에 표시
            present(alert, animated: false)
        } else { print("제목을 입력했습니다.") }
        
    }
    
  
    
    @objc func deleteButtonTapped(_ sender: UIButton ) {
        print("삭제 클릭")
        //메세지창 컨트롤러 인스턴스 생성
//        let alert = UIAlertController(title: "삭제", message: "메모를 삭제 하시겠습니까?", preferredStyle: .alert)

        //메세지창 컨트롤러 버튼액션 인스턴스 생성
//        let delete = UIAlertAction(title: "삭제", style: .default) { _ in
            let point = sender.convert(CGPoint.zero, to: self.checkListView.getCheckTableView()) // 버튼의 테이블뷰 위치 확인
            guard let indexPath = self.checkListView.getCheckTableView().indexPathForRow(at: point) else { return }
            self.checkListArray.remove(at: indexPath.row)
            self.checkListView.getCheckTableView().deleteRows(at: [indexPath], with: .automatic)
//        }
//        let cancle = UIAlertAction(title: "취소", style: .default)

        //메세지창 컨트롤러 버튼액션 추가
//        alert.addAction(delete)
//        alert.addAction(cancle)

        //메세지창 컨트롤러에 표시
//        present(alert, animated: false)
    }

    
//    func resizingTextView() {
//
//        print(memoView.getMemoTextView().text!)
//
//        let size = CGSize(width: view.frame.width, height: .infinity)
//
//        //인자 size를 TextView에 적합한 크기(폰트 사이즈)로 계산
//        let estimatedSize = memoView.getMemoTextView().sizeThatFits(size)
//
//        memoView.getMemoTextView().constraints.forEach { (constraint) in
//            // 높이가 300 이상일 때 300 이상으로 넘어가지 않도록 하기
//            if estimatedSize.height >= 300 {
//                constraint.constant = 300
//            } else {
//                if constraint.firstAttribute == .height {
//                    constraint.constant = estimatedSize.height
//                }
//
//            }
//    }
}
    
//}


// MARK: - UITableViewDataSource

extension CheckListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return checkListArray.count
    }

//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let checkCell = tableView.dequeueReusableCell(withIdentifier: MemoCheckListTableViewCell.id, for: indexPath) as! MemoCheckListTableViewCell

        checkCell.getListTextField().delegate = self

        checkCell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

        return checkCell

        }
    }

// MARK: - UITextFieldDelegate

extension CheckListViewController: UITextFieldDelegate {

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)

        guard let text = textField.text else {
            return false }

        print(text)

        checkListArray.append(text)

        print(checkListArray)

        checkListView.getCheckTableView().reloadData()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if checkListView.getTitleTextField().text != "" {
            navigationItem.rightBarButtonItem?.tintColor = .black
        } else {
            navigationItem.rightBarButtonItem?.tintColor = .systemGray2
        }

    }
}



//extension MemoViewController: UITextViewDelegate {
//
//    // 텍스트 편집이 시작
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if memoView.getMemoTextView().textColor == UIColor.systemGray3 {
//            memoView.getMemoTextView().text = nil
//            memoView.getMemoTextView().textColor = UIColor.black
//        }
//    }
//    // 텍스트 편집 종료
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if memoView.getMemoTextView().text.isEmpty {
//            memoView.getMemoTextView().text = "내용"
//            memoView.getMemoTextView().textColor = .systemGray3
//        }
//    }
    
//    func textViewDidChange(_ textView: UITextView) {
//        print(#function)
////        resizingTextView()
//        switch saveenum {
//        case .after:
//            resizingTextView()
//        case .before:
//            break
//        }
//    }
//}




