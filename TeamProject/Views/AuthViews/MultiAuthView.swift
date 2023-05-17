//
//  MultiAuthView.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/17.
//

import UIKit

class MultiAuthView: UIView {

    //MARK: - 데이 다이어리 로고 이미지
    let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    //MARK: - 로그인 버튼 모음
    /// 카카오 로그인 버튼
    lazy var kakaoLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "kakaoButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    /// 구글 로그인 버튼
    lazy var googleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "googleButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var appleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "appleButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    /// 이메일 로그인 버튼
    lazy var emailLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "emailButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    //MARK: - 로그인 없이 구경하기 버튼
    lazy var exploreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인 없이 구경하기 >", for: .normal)
        button.titleLabel?.font = UIFont.customFont(ofSize: 16, weight: .regular, fontName: "GowunDodum-Regular")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetAuthLayout
    
    func configureUI() {
        self.backgroundColor = .white
        
        self.addSubview(logoImage)
        
        let stack = UIStackView(arrangedSubviews: [kakaoLoginButton, googleLoginButton, appleLoginButton, emailLoginButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        
        self.addSubview(stack)
        
        self.addSubview(exploreButton)
        
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 250),
            logoImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -480),
            
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 180),
            
            exploreButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            exploreButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 50)
        ])
    }
}
