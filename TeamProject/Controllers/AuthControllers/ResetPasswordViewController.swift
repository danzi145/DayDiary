//
//  ResetPasswordViewController.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/31.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    private var resetPasswordView: ResetPasswordView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    
    //MARK: - AutoLayout
    func configureUI() {
        resetPasswordView = ResetPasswordView()
        resetPasswordView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resetPasswordView)
        
        NSLayoutConstraint.activate([
            resetPasswordView.topAnchor.constraint(equalTo: view.topAnchor),
            resetPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resetPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resetPasswordView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}
