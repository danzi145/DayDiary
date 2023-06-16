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

    
    /// 메모 내용 (Text) - 텍스트뷰 반환
    func getMemoTextView() -> UITextView {
        return memoTextView
    }
    
    // MARK: - Autolayout()

    func setAutoLayout() {
        self.addSubview(titleStackView)
        
        self.addSubview(textView)
        textView.addSubview(contentsView)
        textView.addSubview(memoTextView)

        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        memoTextView.translatesAutoresizingMaskIntoConstraints = false
        


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
            
            
         
            
           
        ])
    }
}

    

