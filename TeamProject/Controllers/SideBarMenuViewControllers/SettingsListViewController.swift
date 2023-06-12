//
//  SettingsListViewController.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import UIKit
import SwiftUI
import FirebaseAuth


//MARK: - Models
struct Section {
    let title: String
    let options: [SettingsOptions]
}

struct SettingsOptions {
    let title: String
    let icon: UIImage?
    let handler: (() -> Void)
}

class SettingsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.separatorStyle = .none
        return table
    }()
    
    var models = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupNavBar()
        
        title = ""
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
            
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.isHidden = false
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
    }

    //MARK: - Model Configure
    func configure() {
        models.append(Section(title: "", options: [
            SettingsOptions(title: "계정",icon: UIImage(systemName: "person.circle"), handler: {
                let vc = UIHostingController(rootView: ManageAccountSetting())
                vc.title = "계정"
                self.navigationController?.pushViewController(vc, animated: true)
            }),
            SettingsOptions(title: "알림 설정",icon: UIImage(systemName: "bell"), handler: {
                let vc = UIHostingController(rootView: NotificationSetting())
                vc.title = "알림 설정"
                self.navigationController?.pushViewController(vc, animated: true)

            }),
            SettingsOptions(title: "화면 잠금", icon: UIImage(systemName: "lock"), handler: {
                let vc = UIHostingController(rootView: LockScreenSetting())
                vc.title = "화면 잠금"
                self.navigationController?.pushViewController(vc, animated: true)

            }),
            SettingsOptions(title: "다크 모드", icon: UIImage(systemName: "moon.fill"), handler: {
                let vc = UIHostingController(rootView: DarkModeSetting())
                vc.title = "다크 모드"
                self.navigationController?.pushViewController(vc, animated: true)
            }),
        ]))
        models.append(Section(title: "", options: [
            SettingsOptions(title: "개인정보처리방침", icon: UIImage(systemName: "doc.plaintext"), handler: {
                let vc = UIHostingController(rootView: PrivacyPolicy())
                vc.title = "개인정보처리방침"
                self.navigationController?.pushViewController(vc, animated: true)
            }),
            SettingsOptions(title: "오픈소스 라이브러리", icon: UIImage(systemName: "books.vertical"), handler: {
                let vc = UIHostingController(rootView: OpenSourceLibrary())
                vc.title = "오픈소스 라이브러리"
                self.navigationController?.pushViewController(vc, animated: true)
            }),
        ]))
        models.append(Section(title: "", options: [
            SettingsOptions(title: "로그아웃", icon: UIImage(systemName: "rectangle.portrait.and.arrow.right"), handler: {
                let firebaseAuth = Auth.auth()
                do {
                  try firebaseAuth.signOut()
                    let loginVC = MultiAuthViewController()
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                       let window = sceneDelegate.window {
                        window.rootViewController = loginVC
                    }
                } catch let signOutError as NSError {
                  print("Error signing out: %@", signOutError)
                }
            }),
        ]))
    }
    
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    
    
    //MARK: - TableView
    // titleForHeaderInSection -> for future use maybe..
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()

        // Add separator line
        let separatorLine = UIView(frame: CGRect(x: 0, y: headerView.frame.size.height - 1, width: tableView.frame.size.width, height: 0.5))
        separatorLine.backgroundColor = .lightGray
        headerView.addSubview(separatorLine)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Return the desired height for the section header
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()

    }

}
