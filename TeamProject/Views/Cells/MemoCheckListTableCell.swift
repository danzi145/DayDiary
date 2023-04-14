//
//  MemoCheckListTableCell.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//

import UIKit

class MemoCheckListTableViewCell: UITableViewCell {
    
    static let id = "MemoCheckListTableViewCell"
    
    
    
    var isCheck: Bool = false {
        didSet {
            let imageName = isCheck ? "square" : "checkmark.square"
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
            checkButton.setImage(UIImage(systemName: imageName, withConfiguration: imageConfig ), for: .normal)
        }
    }
    
    
    
    let checkButton: UIButton = {
        var button = UIButton()
        button.tintColor = .black
        button.backgroundColor = .white
        button.isUserInteractionEnabled = false
        return button
    }()
    
    
    let listTextField: UITextField = {
        var textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 19)
        textField.backgroundColor = .white
        textField.textColor = .black
//        textField.layer.borderColor = UIColor.blue.cgColor
//        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var checkListStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [checkButton, listTextField])
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            isCheck.toggle()
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
    

    // MARK: - 오토레이아웃

    func setAutoLayout() {

        self.contentView.addSubview(checkListStackView)
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        listTextField.translatesAutoresizingMaskIntoConstraints = false
        checkListStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            checkButton.widthAnchor.constraint(equalToConstant: 30),
            
            checkListStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            checkListStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            checkListStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            checkListStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}

