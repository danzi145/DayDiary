//
//  OpenSourceView.swift
//  TeamProject
//
//  Created by 남현준 on 2023/04/28.
//

import UIKit

class OpenSourceView: UIView {
    
    // MARK: - 상단
    private let openSourceLabel: UILabel = {
        let label = UILabel()
        label.text = "오픈소스 라이브러리"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        return label
    }()
    
    // 뒤로가기 버튼
    let backBtn: UIButton = {
         let button = UIButton()
         button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
         button.tintColor = UIColor.black
         return button
     }()
    
    // MARK: - 오픈소스 라이브러리 버튼
    private let openSourceButton: UIButton = {
        let button = UIButton()
        button.setTitle("FSCalendar", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    // MARK: - 오픈소스 라이브러리 이름 옆 Circle이미지
    private let titleDotImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "circle.fill")
        image.tintColor = UIColor.black
        return image
    }()
    
    // MARK: - Circle이미지와 오픈소스 라이브러리 버튼을 묶은 스택뷰
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [titleDotImg, openSourceButton])
//        st.spacing = 1
        st.axis = .horizontal
        st.distribution = .fillProportionally
        st.alignment = .center
        return st
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutoLayout() {
        
        backgroundColor = .white
        addSubview(stackView)
        addSubview(openSourceLabel)
        addSubview(backBtn)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        openSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        titleDotImg.translatesAutoresizingMaskIntoConstraints = false
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            openSourceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 139),
            openSourceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 64),
            
            backBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 61),
            backBtn.heightAnchor.constraint(equalToConstant: 24),
            backBtn.widthAnchor.constraint(equalToConstant: 24),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 122),
            stackView.widthAnchor.constraint(equalToConstant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            
            titleDotImg.widthAnchor.constraint(equalToConstant: 12),
            titleDotImg.heightAnchor.constraint(equalToConstant: 12)
            
            
        ])
        
    }
}
