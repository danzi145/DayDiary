//
//  OpenSourceView.swift
//  TeamProject
//
//  Created by 남현준 on 2023/04/28.
//

import UIKit

class OpenSourceView: UIView {
    
    // MARK: - 오픈소스 라이브러리 버튼
    private let openSourceButton: UIButton = {
        let button = UIButton()
        button.setTitle("FSCalendar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
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
        st.axis = .horizontal
        st.distribution = .fillProportionally
        st.spacing = 6
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleDotImg.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            
            titleDotImg.widthAnchor.constraint(equalToConstant: 9),
            titleDotImg.heightAnchor.constraint(equalToConstant: 9)
            
            
        ])
        
    }
}
