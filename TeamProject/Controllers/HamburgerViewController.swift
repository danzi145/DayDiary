//
//  HamburgerViewController.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/24.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    // MARK: - Object
    
    let hamburgerView = HamburgerView()
    var settingsManager = HamburgerSettingsDataManager()
    
    
    
    // MARK: - Variable

    var dataArray: [HamburgerSettings] = []
    
    
    
    // MARK: - ViewController LifeCycle
    
    override func loadView() {
        super.loadView()
        view = hamburgerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsManager.makeData()
        dataArray = settingsManager.getDataArray()
        hamburgerView.menuTableView.register(HamburgerTableViewCell.self, forCellReuseIdentifier: "DataCell")
        setupNaviBar()
        setupDelegate()
    }
    
    // MARK: - Initial Method
    
    func setupDelegate() {
        hamburgerView.menuTableView.delegate = self
        hamburgerView.menuTableView.dataSource = self
    }
    
    func setupNaviBar() {
        // 네이게션바
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 네비게이션 백 버튼
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

// MARK: - UITableViewDataSource

extension HamburgerViewController: UITableViewDataSource {
    
    // 셀 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // 셀 생성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! HamburgerTableViewCell
        cell.logoimageView.image = dataArray[indexPath.row].logoImage
        cell.settingsNameLabel.text = dataArray[indexPath.row].settingsLabel
        cell.selectionStyle = .none
        return cell
    }
}



// MARK: - UITableViewDelegate

extension HamburgerViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        tableView.deselectRow(at: indexPath, animated: true)
        let accountVC = AccountViewController()
        
        
        print(indexPath.row)
        switch indexPath.row {
        case 0: navigationController?.pushViewController(accountVC, animated: true)
            //우선 동일한 View Push 구현
        case 1: navigationController?.pushViewController(accountVC, animated: true)
        case 2: navigationController?.pushViewController(accountVC, animated: true)
        default: return
        }
    
    }
}


