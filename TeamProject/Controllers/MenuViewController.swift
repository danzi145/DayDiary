//
//  MenuViewController.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/03/29.
//

import UIKit

// MenuView를 컨트롤하는 VC
final class MenuViewController: UIViewController {
    
    private enum MenuOptions: String, CaseIterable {
        case account = "계정"
        case privacy = "개인정보처리방침"
        case library = "오픈소스 라이브러리"
    }
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tv.frame.width, height: 80))
        return tv
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // viewDidLayoutSubviews 시점에서 테이블뷰 프레임 잡기
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 95, y: view.safeAreaInsets.top, width: view.bounds.size.width * 0.75, height: view.bounds.size.height)
    }
    
    
}
    // MARK: - UITableViewDelegate & UITableViewDataSource

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
