//
//  MemoView.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/24.
//

import UIKit

class MemoView : UIView {
    
    let textViewPlaceHolder = "내용"
    
    // MARK: - 메모화면 제목

    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0.4039215686, alpha: 1)
        return view
    }()
    
    private let titleTextField: UITextField = {
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
    
    
    
    // MARK: - 메모화면 내용, 텍스트 부분

    private let textFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let textContentsView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0.4039215686, alpha: 1)
        return view
    }()
    
    
    lazy var memoTextView: UITextView = {
        let textview = UITextView()
//        textview.backgroundColor = .darkGray
        textview.font = UIFont.systemFont(ofSize: 18)
        textview.text = textViewPlaceHolder
        textview.textColor = .lightGray
        return textview
    }()
    
    // MARK: - 메모화면 내용, 체크리스트 부분
    private let checkFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    

    private let checkContentsView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0.4039215686, alpha: 1)
        return view
    }()
    
    var memoTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .green
        return tableview
    }()
    
    
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        memoTableView.allowsMultipleSelection = true // 체크 버튼
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - 오토레이아웃

    
    func setAutoLayout() {
        self.addSubview(titleStackView)
        
        self.addSubview(textFrameView)
        textFrameView.addSubview(textContentsView)
        textFrameView.addSubview(memoTextView)
        
        self.addSubview(checkFrameView)
        checkFrameView.addSubview(checkContentsView)
        checkFrameView.addSubview(memoTableView)
        
        
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        textFrameView.translatesAutoresizingMaskIntoConstraints = false
        textContentsView.translatesAutoresizingMaskIntoConstraints = false
        memoTextView.translatesAutoresizingMaskIntoConstraints = false
        
        checkFrameView.translatesAutoresizingMaskIntoConstraints = false
        checkContentsView.translatesAutoresizingMaskIntoConstraints = false
        memoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            titleView.widthAnchor.constraint(equalToConstant: 6),
            
            titleStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleStackView.heightAnchor.constraint(equalToConstant: 41),
            
            
            
            textFrameView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 20),
            textFrameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textFrameView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textFrameView.heightAnchor.constraint(equalToConstant: 300),
            
            textContentsView.topAnchor.constraint(equalTo: textFrameView.topAnchor),
            textContentsView.leadingAnchor.constraint(equalTo: textFrameView.leadingAnchor),
            textContentsView.widthAnchor.constraint(equalToConstant: 6),
            textContentsView.heightAnchor.constraint(equalToConstant: 41),
            
            memoTextView.topAnchor.constraint(equalTo: textFrameView.topAnchor),
            memoTextView.leadingAnchor.constraint(equalTo: textContentsView.trailingAnchor),
            memoTextView.trailingAnchor.constraint(equalTo: textFrameView.trailingAnchor),
            memoTextView.bottomAnchor.constraint(equalTo: textFrameView.bottomAnchor),
            
            
            
            checkFrameView.topAnchor.constraint(equalTo: textFrameView.bottomAnchor, constant: 5),
            checkFrameView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            checkFrameView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            checkFrameView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
             
            checkContentsView.topAnchor.constraint(equalTo: checkFrameView.topAnchor),
            checkContentsView.leadingAnchor.constraint(equalTo: checkFrameView.leadingAnchor),
            checkContentsView.widthAnchor.constraint(equalToConstant: 6),
            checkContentsView.heightAnchor.constraint(equalToConstant: 41),
            
            memoTableView.topAnchor.constraint(equalTo: checkFrameView.topAnchor),
            memoTableView.leadingAnchor.constraint(equalTo: checkContentsView.trailingAnchor),
            memoTableView.trailingAnchor.constraint(equalTo: checkFrameView.trailingAnchor),
            memoTableView.bottomAnchor.constraint(equalTo: checkFrameView.bottomAnchor)
       
        ])
    }
    
   
}

    


