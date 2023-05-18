//
//  NextSceneViewController.swift
//  DayDiaryPractice
//
//  Created by seoha on 2023/04/05.
//

import UIKit

class WaitingPopupViewController: UIViewController {

    override func loadView() {
        self.view = WaitingPopupview()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 확인하기 버튼 누르면 동작하는 함수
        func checkingButtonTapped() {
            
            print("다음 화면으로 넘어가기")
        }
        
        // 기다리기 버튼 누르면 동작하는 함수
        func waitingButtonTapped() {
            
            print("다음 화면으로 넘어가기")
        }
        
    }
    

}


