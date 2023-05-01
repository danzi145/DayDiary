//
//  MemoView.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//

import UIKit

class MemoView : UIView {
    
    // MARK: - 메모화면 제목입력 뷰
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0.4039215686, alpha: 1)
        return view
    }()
    
    // 메모화면 제목 - 텍스트필드 구현
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleView, titleTextField])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    
    
    
    // MARK: - 메모화면 텍스트 입력

//    // 메모화면 내용 - 테이블뷰, 버튼뷰의 프레임 뷰
    private let textView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0.4039215686, alpha: 1)
        return view
    }()
    
    let memoTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "내용"
        textView.textColor = .systemGray3
        return textView
    }()
    
    // MARK: - 메모화면 체크리스트 입력

    private let checkView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let checkContentsView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0.4039215686, alpha: 1)
        return view
    }()
    
    // 메모화면 내용 - 테이블뷰 구현
    let memoTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .white
        tableview.separatorColor = .clear
        tableview.register(MemoCheckListTableViewCell.self, forCellReuseIdentifier: MemoCheckListTableViewCell.id)
        tableview.rowHeight = 41
        return tableview
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
//        memoTableView.allowsMultipleSelection = true // 체크 버튼
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 오토레이아웃

    func setAutoLayout() {
        self.addSubview(titleStackView)
        
        self.addSubview(textView)
        textView.addSubview(contentsView)
        textView.addSubview(memoTextView)
        
        self.addSubview(checkView)
        checkView.addSubview(checkContentsView)
        checkView.addSubview(memoTableView)
    

        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        memoTextView.translatesAutoresizingMaskIntoConstraints = false
        
        checkView.translatesAutoresizingMaskIntoConstraints = false
        checkContentsView.translatesAutoresizingMaskIntoConstraints = false
        memoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        

        NSLayoutConstraint.activate([
            titleView.widthAnchor.constraint(equalToConstant: 7),
            
            titleStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleStackView.heightAnchor.constraint(equalToConstant: 41),

            
            
            textView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 300),
            
            contentsView.topAnchor.constraint(equalTo: textView.topAnchor),
            contentsView.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            contentsView.widthAnchor.constraint(equalToConstant: 7),
            contentsView.heightAnchor.constraint(equalToConstant: 41),
            
            memoTextView.topAnchor.constraint(equalTo: textView.topAnchor),
            memoTextView.leadingAnchor.constraint(equalTo: contentsView.trailingAnchor, constant: 2),
            memoTextView.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            memoTextView.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
            
            
            
            checkView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            checkView.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            checkView.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            checkView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            checkContentsView.topAnchor.constraint(equalTo: checkView.topAnchor),
            checkContentsView.leadingAnchor.constraint(equalTo: checkView.leadingAnchor),
            checkContentsView.widthAnchor.constraint(equalToConstant: 7),
            checkContentsView.heightAnchor.constraint(equalToConstant: 41),
            
            memoTableView.topAnchor.constraint(equalTo: checkView.topAnchor),
            memoTableView.leadingAnchor.constraint(equalTo: checkContentsView.trailingAnchor, constant: 5),
            memoTableView.trailingAnchor.constraint(equalTo: checkView.trailingAnchor),
            memoTableView.bottomAnchor.constraint(equalTo: checkView.bottomAnchor),
        ])
    }
}

    


