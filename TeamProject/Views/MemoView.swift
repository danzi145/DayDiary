//
//  MemoView.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//

import UIKit

class MemoView : UIView {
    
    // MARK: - Properties
    
    // Memo Title
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColor")
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
    
    
    
    
     // Memo contents - Text
    private let textView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColor")
        return view
    }()
    
    private let memoTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "내용"
        textView.textColor = .systemGray3
        return textView
    }()
    
    
    

    // Memo contents - CheckList
    private let checkView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let checkContentsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColor")
        return view
    }()
    
    private let memoTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .white
        tableview.separatorColor = .clear
        tableview.register(MemoCheckListTableViewCell.self, forCellReuseIdentifier: MemoCheckListTableViewCell.id)
        tableview.rowHeight = 41
        return tableview
    }()
    
    
    
    
    // Memo Bottom Button
    
    private lazy var bottomButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var plusCheckButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "checkmark.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        return button
    }()
    
    private let trashButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        return button
    }()

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    /// 메모 제목 - 텍스트필드 반환
    func getTitleTextField() -> UITextField {
        return titleTextField
    }
    
    /// 메모 내용 (CheckList) - 테이블뷰 반환
    func getMemoTableView() -> UITableView {
        return memoTableView
    }
    
    /// 메모 내용 (Text) - 텍스트뷰 반환
    func getMemoTextView() -> UITextView {
        return memoTextView
    }
    
    func getPlusCheckButton() -> UIButton {
        return plusCheckButton
    }
    
    func getTrashButton() -> UIButton {
        return trashButton
    }
    
    // MARK: - Autolayout()

    func setAutoLayout() {
        self.addSubview(titleStackView)
        
        self.addSubview(textView)
        textView.addSubview(contentsView)
        textView.addSubview(memoTextView)
        
        self.addSubview(checkView)
        checkView.addSubview(checkContentsView)
        checkView.addSubview(memoTableView)
        
        self.addSubview(bottomButtonView)
        bottomButtonView.addSubview(plusCheckButton)
        bottomButtonView.addSubview(trashButton)
    

        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        memoTextView.translatesAutoresizingMaskIntoConstraints = false
        
        checkView.translatesAutoresizingMaskIntoConstraints = false
        checkContentsView.translatesAutoresizingMaskIntoConstraints = false
        memoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomButtonView.translatesAutoresizingMaskIntoConstraints = false
        plusCheckButton.translatesAutoresizingMaskIntoConstraints = false
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        

        NSLayoutConstraint.activate([
            titleView.widthAnchor.constraint(equalToConstant: 7),
            
            titleStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleStackView.heightAnchor.constraint(equalToConstant: 41),

            
            
            textView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo:  memoTextView.bottomAnchor),
            
            contentsView.topAnchor.constraint(equalTo: textView.topAnchor),
            contentsView.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            contentsView.widthAnchor.constraint(equalToConstant: 7),
            contentsView.heightAnchor.constraint(equalToConstant: 41),
            
            memoTextView.topAnchor.constraint(equalTo: textView.topAnchor),
            memoTextView.leadingAnchor.constraint(equalTo: contentsView.trailingAnchor, constant: 2),
            memoTextView.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            memoTextView.heightAnchor.constraint(equalToConstant: 300),
            
            
            
            checkView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            checkView.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            checkView.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            checkView.bottomAnchor.constraint(equalTo: bottomButtonView.topAnchor),
            
            checkContentsView.topAnchor.constraint(equalTo: checkView.topAnchor),
            checkContentsView.leadingAnchor.constraint(equalTo: checkView.leadingAnchor),
            checkContentsView.widthAnchor.constraint(equalToConstant: 7),
            checkContentsView.heightAnchor.constraint(equalToConstant: 41),
            
            memoTableView.topAnchor.constraint(equalTo: checkView.topAnchor),
            memoTableView.leadingAnchor.constraint(equalTo: checkContentsView.trailingAnchor, constant: 5),
            memoTableView.trailingAnchor.constraint(equalTo: checkView.trailingAnchor),
            memoTableView.bottomAnchor.constraint(equalTo: checkView.bottomAnchor),
            
            
            
            bottomButtonView.leadingAnchor.constraint(equalTo: checkView.leadingAnchor ),
            bottomButtonView.trailingAnchor.constraint(equalTo: checkView.trailingAnchor),
            bottomButtonView.heightAnchor.constraint(equalToConstant: 30),
            bottomButtonView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            
            plusCheckButton.topAnchor.constraint(equalTo: bottomButtonView.topAnchor),
            plusCheckButton.leadingAnchor.constraint(equalTo: bottomButtonView.leadingAnchor),
            plusCheckButton.bottomAnchor.constraint(equalTo: bottomButtonView.bottomAnchor),
            plusCheckButton.widthAnchor.constraint(equalToConstant: 40),
            
            
            trashButton.topAnchor.constraint(equalTo: bottomButtonView.topAnchor),
            trashButton.trailingAnchor.constraint(equalTo: bottomButtonView.trailingAnchor),
            trashButton.bottomAnchor.constraint(equalTo: bottomButtonView.bottomAnchor),
            trashButton.widthAnchor.constraint(equalToConstant: 40),
            
           
        ])
    }
}

    


