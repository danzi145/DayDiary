//
//  NavBarAppearance.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import UIKit

extension UINavigationController {
    
    func setupNavBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
                
        navigationController?.navigationBar.tintColor = .black
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        
        self.navigationBar.tintColor = .black
        UIBarButtonItem.appearance().tintColor = .black
    }
}

