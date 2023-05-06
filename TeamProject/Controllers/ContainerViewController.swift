//
//  ContainerViewController.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/03/29.
//

import UIKit

// MonthlyVC 와 MenuVC를 담는 ContainerVC
final class ContainerViewController: UIViewController {
    
    // 사이드 메뉴가 열리거나 닫힌 경우를 분기처리
    private enum MenuState {
        case opened
        case closed
    }
    
    // default 상태: closed
    private var menuState: MenuState = .closed
    
    private let monthlyVC = MonthlyViewController()
    private let menuVC = MenuViewController()
    private var navVC: UINavigationController?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addChildVC()
    }
    
    
    // MARK: - Helpers
    private func addChildVC() {
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        monthlyVC.delegate = self
        let navVC = UINavigationController(rootViewController: monthlyVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
    
}

// MARK: - MonthlyViewControllerDelegate

extension ContainerViewController: MonthlyViewControllerDelegate {
    func didTapMenuButton() {
        switch menuState {
        case .closed: // menuState가 닫힌 상태에서 버튼 누르면 실행되는 함수들 (메뉴가 열리도록 구현)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                if #available(iOS 16.0, *) {
                    self.navVC?.view.frame.origin.x = self.monthlyVC.view.anchorPoint.x - 290
                } else {
                    // Fallback on earlier versions
                }
                self.monthlyVC.topStackView.menuButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
            
        case .opened: // menuState가 닫힌 상태에서 버튼 누르면 실행되는 함수들 (메뉴가 닫히도록 구현)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
                self.monthlyVC.topStackView.menuButton.setImage(UIImage(systemName: "text.justify"), for: .normal)
            } completion: { done in
                if done {
                    self.menuState = .closed
                }
            }
            
            
        }
        
    }
    
    
    
    
}
