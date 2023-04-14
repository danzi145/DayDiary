//
//  MemoTextCell.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//
import UIKit

final class MemoTextTableViewCell: UITableViewCell {
    
    static let id = "MemoTextTableViewCell"
    
    
    
    var memoTextview: UITextView = {
        var textView = UITextView()
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.backgroundColor = .white
        textView.textColor = .black
//        textView.layer.borderColor = UIColor.systemGreen.cgColor
//        textView.layer.borderWidth = 1
        textView.font = UIFont.systemFont(ofSize: 19)
        return textView
    }()
    
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        self.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - 오토레이아웃

    func setAutoLayout() {
        self.contentView.addSubview(memoTextview)
        
        memoTextview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            memoTextview.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            memoTextview.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            memoTextview.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            memoTextview.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0)
        ])
    }
}

