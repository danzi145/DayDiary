//
//  HamburgerTableViewCell.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/24.
//

import UIKit

final class HamburgerTableViewCell: UITableViewCell {
    
    
    let logoimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        return imageView
    }()
    
    let settingsNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        return label
        
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - 오토레이아웃

    func setAutoLayout() {
        self.contentView.addSubview(logoimageView)
        self.contentView.addSubview(settingsNameLabel)
        
        logoimageView.translatesAutoresizingMaskIntoConstraints = false
        settingsNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoimageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            logoimageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            logoimageView.heightAnchor.constraint(equalToConstant: 30),
            logoimageView.widthAnchor.constraint(equalToConstant: 30),
            
            settingsNameLabel.leadingAnchor.constraint(equalTo: logoimageView.trailingAnchor, constant: 10),
            settingsNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            settingsNameLabel.topAnchor.constraint(equalTo: self.logoimageView.topAnchor),
            settingsNameLabel.bottomAnchor.constraint(equalTo: self.logoimageView.bottomAnchor)
            
        ])
        
    }
}


