//
//  AccountViewController.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//
import UIKit


class SocialLoginAccountViewController: UIViewController {
    
    // MARK: - Object
    
    private let headerView = MenuHeaderStackView(title: "계정")
    private let accountView = SocialLoginAccountView()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerView, accountView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        setAutolayout()

        headerView.backButton.addTarget(self,
                                        action: #selector(backButtonTapped),
                                        for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    private func setAutolayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
