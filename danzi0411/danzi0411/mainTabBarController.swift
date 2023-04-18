//
//  titleView.swift
//  danzi0411
//
//  Created by 박채운 on 2023/04/10.
//

import UIKit
import SnapKit
import Then

class mainTabBarController: UITabBarController {

//    private lazy var firstNC: UIButton = {
//
//        let button = UIButton(type: .custom)
//        title = "hh"
//        button.backgroundColor = .blue
//        button.setTitle("Login", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 1, weight: .bold)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
//
//        return firstNC
//    }()
    
    
    
    
    private lazy var passwordResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {

        
        

        
        
        
        let firstNC = UINavigationController.init(rootViewController: ViewController(title: "", bgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        
        self.viewControllers = [firstNC]
        let firstTabBarItem = UITabBarItem(title: " ", image: UIImage(systemName: ""), tag: 0)
       
        firstNC.tabBarItem = firstTabBarItem
       

    }
    @objc func loginButtonTapped() {

        // 전화면의 isLoggedIn속성에 접근하기 ⭐️
//        if let presentingVC = presentingViewController { // 옵셔널 바인딩
//            let tabBarCon = presentingVC as! UITabBarController   // 탭바에 접근하기
//            let nav = tabBarCon.viewControllers?[0] as! UINavigationController  // 네비게이션바에 접근하기
//            let firstVC = nav.viewControllers[0] as! FirstViewController  // FirstVC에 접근하기
//            firstVC.isLoggedIn.toggle()  // 로그인 되었다고 상태 변화시키기 (실제 앱에서 이렇게 구현할 일은 없음)
//        }

        dismiss(animated: true, completion: nil)
    }

    @objc func resetButtonTapped() {
        //만들기
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인버튼이 눌렸습니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소버튼이 눌렸습니다.")
        }

        alert.addAction(success)
        alert.addAction(cancel)

        // 실제 띄우기
        self.present(alert, animated: true, completion: nil)
    }
}

