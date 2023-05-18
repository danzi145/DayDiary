//
//  MemoCheckListTableCell.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//

import UIKit

class MemoCheckListTableViewCell: UITableViewCell {
    
    static let id = "MemoCheckListTableViewCell"
    
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "checkmark.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    private let listTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.placeholder = "내용"
        return textField
    }()
    
 
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        button.setImage(UIImage(systemName: "multiply.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16)), for: .normal)
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //listTextField.text = nil
        // if문 활용
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        self.backgroundColor = .white
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    /// 메모 테이블셀 - 체크리스트 텍스트필드
    func getListTextField() -> UITextField{
        return listTextField
    }
    
    // 체크버튼 클릭시 체크버튼 이미지 변경
    @objc func checkButtonTapped() {
        if checkButton.currentImage == UIImage(systemName: "checkmark.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)) {
            checkButton.setImage(UIImage(systemName: "checkmark.square.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        } else { checkButton.setImage(UIImage(systemName: "checkmark.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        }
    }

    
    // MARK: - AutoLayout

    func setAutoLayout() {

        self.contentView.addSubview(checkButton)
        self.addSubview(listTextField)
        self.addSubview(deleteButton)
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        listTextField.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            checkButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            checkButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            checkButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 2),
            checkButton.widthAnchor.constraint(equalToConstant: 25),
            
            listTextField.topAnchor.constraint(equalTo: self.topAnchor),
            listTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            listTextField.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 2),
            listTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            deleteButton.topAnchor.constraint(equalTo: self.topAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: listTextField.trailingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

