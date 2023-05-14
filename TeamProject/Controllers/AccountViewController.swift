//
//  AccountViewController.swift
//  TeamProject
//
//  Created by 최민경 on 2023/04/14.
//
import UIKit


class AccountViewController: UIViewController {
    
    // MARK: - Object

    let accountView = AccountView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = accountView
        title = "계정"
        
        
        
    }
}
