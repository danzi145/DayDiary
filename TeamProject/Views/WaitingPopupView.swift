//
//  WatingPopupview.swift
//  DayDiaryPractice
//
//  Created by seoha on 2023/04/05.
//

import UIKit

class WaitingPopupview: UIView {
    
    
    
    
    //팝업 형태 잡기
    let popupBox: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemBackground
        view.layer.borderColor = .init(red: 151/255, green: 151/255, blue: 151/255, alpha: 0.5)
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        //view.addSubview
        return view
    }()
    
    //타이틀
    var boxLabel: UILabel = {
        var label = UILabel()
        label.text = "04.03(월)"
        //lable.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    // 내용 영역
    var boxText: UILabel = {
        let tf = UILabel()
        tf.frame.size.height = 60
        tf.backgroundColor = .clear
        tf.textColor = .black
        //tf.sizeToFit()
        tf.text = """
        ‘수박이 먹고 싶은 날’은
        4월 28일에 열리는
        시간차 일기입니다.
        """
        tf.textAlignment = .center
        let newsize = tf.intrinsicContentSize
        tf.frame.size = newsize
        tf.lineBreakMode = .byCharWrapping
        tf.numberOfLines = 0
        return tf
    }()
    
    
    
    //기다리기 버튼
    private var waitingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitle("두근두근! 기다리기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false
        button.addTarget(WaitingPopupview.self, action: #selector(waitingButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // 기다리기 버튼 누르면 동작하는 함수
    @objc func waitingButtonTapped() {
        // 다음 화면으로 넘어가는 내용 구현
        print("다음 화면으로 넘어가기")
    }
    
    
    
    //확인하기 버튼
    private let checkingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = .init(red: 151/255, green: 151/255, blue: 151/255, alpha: 0.5)
        button.setTitle("에잇! 바로 확인하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        button.addTarget(WaitingPopupview.self, action: #selector(checkingButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // 기다리기 버튼 누르면 동작하는 함수
    @objc func checkingButtonTapped() {
        // 다음 화면으로 넘어가는 내용 구현
        print("다음 화면으로 넘어가기")
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 0.3)
        
        addSubview(popupBox)
        
        setupViews()
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //오토레이아웃
    func setupViews() {
        
        popupBox.translatesAutoresizingMaskIntoConstraints = false
        popupBox.heightAnchor.constraint(equalToConstant: 314).isActive = true
        popupBox.widthAnchor.constraint(equalToConstant: 250).isActive = true
        popupBox.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        popupBox.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(boxLabel)
        boxLabel.translatesAutoresizingMaskIntoConstraints = false
        boxLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        boxLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 300).isActive = true
        boxLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        boxLabel.widthAnchor.constraint(equalToConstant: 183).isActive = true
        
        addSubview(boxText)
        boxText.translatesAutoresizingMaskIntoConstraints = false
        boxText.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        boxText.heightAnchor.constraint(equalToConstant: 150).isActive = true
        boxText.widthAnchor.constraint(equalToConstant: 183).isActive = true
        boxText.topAnchor.constraint(equalTo: self.topAnchor, constant: 300).isActive = true
        
        
        addSubview(waitingButton)
        waitingButton.translatesAutoresizingMaskIntoConstraints = false
        waitingButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        waitingButton.widthAnchor.constraint(equalToConstant: 183).isActive = true
        waitingButton.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        waitingButton.centerYAnchor.constraint(equalTo: popupBox.centerYAnchor, constant: 50).isActive = true
        
        addSubview(checkingButton)
        checkingButton.translatesAutoresizingMaskIntoConstraints = false
        checkingButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        checkingButton.widthAnchor.constraint(equalToConstant: 183).isActive = true
        checkingButton.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        checkingButton.centerYAnchor.constraint(equalTo: popupBox.centerYAnchor, constant: 100).isActive = true
    }
    
}

