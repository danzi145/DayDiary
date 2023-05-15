//
//  HamburgerMenuView.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//

import UIKit

class HamburgerView: UIView {
    
    private let menuTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .white
        tableview.rowHeight = 49
        tableview.isScrollEnabled = false
        return tableview
    }()
    
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .white
        label.textColor = .black
        label.text = "버전정보 1.0.0"
        return label
    }()
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
//        setAutoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Custom Method
    
    /// 메뉴 - 테이블뷰 반환
    func getMenuTableView() -> UITableView {
        return menuTableView
    }
    
    /// 테이블 헤더뷰 세팅하는 함수 ( 세팅 다 되면 오토레이아웃도 같이 세팅되도록 구현)
    func setTableHeaderView() {
        menuTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 60))
        setAutoLayout()
    }
    
    // MARK: - AutoLayout
    
    func setAutoLayout(){
        addSubview(menuTableView)
        addSubview(versionLabel)

       
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            menuTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            menuTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            menuTableView.heightAnchor.constraint(equalToConstant: 313),
            
            versionLabel.topAnchor.constraint(equalTo: menuTableView.bottomAnchor , constant: 40),
            versionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            versionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            versionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
    
