//
//  MemoView.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//

import UIKit

class MemoView : UIView {
    
    // MARK: - 메모화면 제목입력 뷰
    
    let titleView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0.4039215686, alpha: 1)
        return view
    }()
    
    // 메모화면 제목 - 텍스트필드 구현
    let titleTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "제목"
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 19)
//        textField.layer.borderColor = UIColor.red.cgColor
//        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var titleStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [titleView, titleTextField])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    
    
    
    // MARK: - 메모화면 내용입력 뷰

    // 메모화면 내용 - 테이블뷰, 버튼뷰의 프레임 뷰
    let frameView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let contentsView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0.4039215686, alpha: 1)
        return view
    }()
    
    
    // 메모화면 내용 - 테이블뷰 구현
    let memoTableView: UITableView = {
        var tableview = UITableView()
        tableview.backgroundColor = .white
        tableview.separatorColor = .clear
        tableview.register(MemoTextTableViewCell.self, forCellReuseIdentifier: MemoTextTableViewCell.id)
        tableview.register(MemoCheckListTableViewCell.self, forCellReuseIdentifier: MemoCheckListTableViewCell.id)
//        tableview.layer.borderWidth = 1
//        tableview.layer.borderColor = UIColor.systemPink.cgColor
        return tableview
    }()
    
    // 메모화면 내용 - 하단 버튼 뷰
    let buttonView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // 메모화면 내용 - 하단 버튼뷰 위에 저장버튼 구현
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // 메모화면 내용 - 하단 버튼뷰 위에 체크버튼 구현
    let checkButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        button.setImage(UIImage(systemName: "app.badge.checkmark", withConfiguration: imageConfig), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        return button
    }()
    
//    let textButton: UIButton = {
//        let button = UIButton()
//        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
//        button.setImage(UIImage(systemName: "app.badge", withConfiguration: imageConfig), for: .normal)
//        button.tintColor = .black
//        button.backgroundColor = .white
//        return button
//    }()
    
    // 키보드 높이에 따른 프레임뷰 높이 조정을 위한 레이아웃 (키보드에 입력창 가려지지 않도록)
    lazy var frameautoLayout = frameView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0)
    
    
    
    
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
        self.addSubview(frameView)
        frameView.addSubview(memoTableView)
        frameView.addSubview(buttonView)
        memoTableView.addSubview(contentsView)
        buttonView.addSubview(saveButton)
        buttonView.addSubview(checkButton)
//        buttonView.addSubview(textButton)
        

        titleView.translatesAutoresizingMaskIntoConstraints = false
        frameView.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        memoTableView.translatesAutoresizingMaskIntoConstraints = false
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.translatesAutoresizingMaskIntoConstraints = false
//        textButton.translatesAutoresizingMaskIntoConstraints = false
        frameautoLayout.isActive = true // 테이블뷰 높이 레이아웃
        
        
        NSLayoutConstraint.activate([
            titleView.widthAnchor.constraint(equalToConstant: 7),
            
            titleStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleStackView.heightAnchor.constraint(equalToConstant: 50),
            
            frameView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 10),
            frameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            frameView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            memoTableView.topAnchor.constraint(equalTo: frameView.topAnchor),
            memoTableView.leadingAnchor.constraint(equalTo: frameView.leadingAnchor),
            memoTableView.trailingAnchor.constraint(equalTo: frameView.trailingAnchor),
            memoTableView.bottomAnchor.constraint(equalTo: frameView.bottomAnchor, constant: -65),
            
            contentsView.topAnchor.constraint(equalTo: memoTableView.topAnchor),
            contentsView.leadingAnchor.constraint(equalTo: memoTableView.leadingAnchor),
            contentsView.widthAnchor.constraint(equalToConstant: 7),
            contentsView.heightAnchor.constraint(equalToConstant: 50),
            
            buttonView.bottomAnchor.constraint(equalTo: frameView.bottomAnchor),
            buttonView.topAnchor.constraint(equalTo: memoTableView.bottomAnchor, constant: 5),
            buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 2),
            saveButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -10),
            saveButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -2),
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            
            checkButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 2),
            checkButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 10),
            checkButton.widthAnchor.constraint(equalToConstant: 50),
            checkButton.heightAnchor.constraint(equalToConstant: 50),
            
//            textButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 2),
//            textButton.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 8),
//            textButton.widthAnchor.constraint(equalToConstant: 50),
//            textButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
    
   
}

    


