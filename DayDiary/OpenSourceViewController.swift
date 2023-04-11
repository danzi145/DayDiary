//
//  OpenSourceViewController.swift
//  DayDiary
//
//  Created by 남현준 on 2023/03/29.
//

import UIKit

class OpenSourceViewController: UIViewController {

    private let openSourceLabel: UILabel = {
        let label = UILabel()
        label.text = "오픈소스 라이브러리"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        return label
    }()
    
    private let openSourceButton: UIButton = {
        let button = UIButton()
        button.setTitle("FSCalendar", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private let titleDotImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "circle.fill")
        image.tintColor = UIColor.black
        return image
    }()
    
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [titleDotImg, openSourceButton])
//        st.spacing = 1
        st.axis = .horizontal
        st.distribution = .fillProportionally
        st.alignment = .center
        return st
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAutoLayout()
        
    }
    
    
    func setAutoLayout() {
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(openSourceLabel)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        openSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        titleDotImg.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            openSourceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 139),
            openSourceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 122),
            stackView.widthAnchor.constraint(equalToConstant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            
            titleDotImg.widthAnchor.constraint(equalToConstant: 12),
            titleDotImg.heightAnchor.constraint(equalToConstant: 12)
            
            
        ])
        
    }

    
}
