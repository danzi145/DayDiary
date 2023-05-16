//
//  HamburgerViewController.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//

import UIKit

struct HamburgerSettings {
    var logoImage: UIImage?
    var settingsLabel: String
}

class HamburgerViewController: UIViewController {
    
    // MARK: - Object
    
    let hamburgerView = HamburgerView()
    let headerView = MenuHeaderStackView(title: "")
    
    // MARK: - Variable

    let dataArray = [
        HamburgerSettings(logoImage: UIImage(systemName: "person.circle"), settingsLabel: "계정"),
        HamburgerSettings(logoImage: UIImage(systemName: "doc.plaintext"), settingsLabel: "개인정보처리방침"),
        HamburgerSettings(logoImage: UIImage(systemName: "books.vertical"), settingsLabel: "오픈소스 라이브러리")
    ]
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(hamburgerView)
        setAutolayout()
        
        hamburgerView.getMenuTableView().register(HamburgerSettingsTableCell.self, forCellReuseIdentifier: "DataCell")
        setupDelegate()
        
        // 커스텀뷰의 백버튼에 대한 액션 (dismiss)
        headerView.backButton.addTarget(self,
                                        action: #selector(backButtonTapped),
                                        for: .touchUpInside)
    }
    

    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Initial Method
    
    private func setAutolayout() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        hamburgerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            hamburgerView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            hamburgerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            hamburgerView.heightAnchor.constraint(equalToConstant: view.frame.height - headerView.frame.height)
        ])
    }
    
    private func setupDelegate() {
        hamburgerView.getMenuTableView().delegate = self
        hamburgerView.getMenuTableView().dataSource = self
    }

}

// MARK: - UITableViewDataSource

extension HamburgerViewController: UITableViewDataSource {
    
    // 셀 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // 셀 생성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! HamburgerSettingsTableCell
        cell.getLogoimageView().image = dataArray[indexPath.row].logoImage
        cell.getSettingsNameLabel().text = dataArray[indexPath.row].settingsLabel
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
        let personalVC = PersonalInfoViewController()
        let opensourceVC = OpenSourceViewController()
        
        switch indexPath.row {
        case 0: navigationController?.pushViewController(accountVC, animated: true)
        case 1: navigationController?.pushViewController(personalVC, animated: true)
        case 2: navigationController?.pushViewController(opensourceVC, animated: true)
        default: return
        }
    
    }
    
    
    
}

