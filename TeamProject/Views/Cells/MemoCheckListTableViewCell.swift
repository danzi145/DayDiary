//
//  MemoCheckListTableViewCell.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/24.
//

import UIKit

class MemoCheckListTableViewCell: UITableViewCell {
    
    static let id = "MemoCheckListTableViewCell"

    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    
    
    
    let listTextField: UITextField = {
        var textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 19)
        textField.backgroundColor = .white
        textField.textColor = .black
        return textField
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0.6571641564, green: 0.6571640372, blue: 0.6571640372, alpha: 1)
        button.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        button.backgroundColor = .white
        return button
    }()


    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        listTextField.becomeFirstResponder()
        }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        self.backgroundColor = .white
        self.selectionStyle = .none
        contentView.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func checkButtonTapped() {
        print(#function)
        if checkButton.currentImage == UIImage(systemName: "square") {
            checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            checkButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    

    // MARK: - 오토레이아웃

    func setAutoLayout() {

        self.addSubview(checkButton)
        self.contentView.addSubview(listTextField)
        self.contentView.addSubview(deleteButton)
        
        

        checkButton.translatesAutoresizingMaskIntoConstraints = false
        listTextField.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            checkButton.topAnchor.constraint(equalTo: self.topAnchor),
            checkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            checkButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: 30),
            
            listTextField.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            listTextField.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 5),
            listTextField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            listTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -25),
            
            deleteButton.topAnchor.constraint(equalTo: self.topAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: listTextField.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

