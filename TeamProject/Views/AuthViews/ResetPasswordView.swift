//
//  ResetPasswordView.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/31.
//

import UIKit

class ResetPasswordView: UIView {

    private let scrollView: UIScrollView = {
           let scrollView = UIScrollView()
           scrollView.clipsToBounds = true
           return scrollView
       }()
       
       
       private let mainLabel: UILabel = {
           let label = UILabel()
           label.text = "비밀번호 재설정"
           label.font = UIFont.customFont(ofSize: 20, weight: .bold, fontName: "GowunDodum-Regular")
           label.textAlignment = .center
           return label
       }()
       
       private let emailLabel: UILabel = {
           let label = UILabel()
           label.text = "이메일"
           label.font = UIFont.customFont(ofSize: 16, weight: .regular, fontName: "GowunDodum-Regular")
           label.textAlignment = .left
           return label
       }()
       
       private let descriptionLabel: UILabel = {
           let label = UILabel()
           label.text = "가입되어 있는 이메일 주소를 입력해 주세요."
           label.font = UIFont.customFont(ofSize: 13, weight: .regular, fontName: "GowunDodum-Regular")
           label.textColor = .gray
           label.textAlignment = .left
           return label
       }()
       
       private let emailTextField: UITextField = {
           let field = UITextField()
           let placeholderText = NSAttributedString(string: "이메일을 입력해주세요", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)])
           field.autocapitalizationType = .none
           field.autocorrectionType = .no
           field.returnKeyType = .continue
           field.keyboardType = .emailAddress
           field.layer.cornerRadius = 8
           field.layer.borderWidth = 0.5
           field.layer.borderColor = UIColor.lightGray.cgColor
           field.attributedPlaceholder = placeholderText
           field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
           field.leftViewMode = .always
           field.backgroundColor = .white
           return field
       }()
       
       private let detailsLabel: UILabel = {
           let label = UILabel()
           label.text = "• 전송된 메일로 인증하시면 임시 비밀번호가 발급됩니다.\n• 인증 메일은 발송 후 24시간 내에만 유효합니다."
           label.font = UIFont.customFont(ofSize: 13, weight: .regular, fontName: "GowunDodum-Regular")
           label.textColor = .gray
           label.textAlignment = .left
           label.numberOfLines = 0 // Allow multiple lines
           return label
       }()
       
       
       private lazy var resetPasswordButton: UIButton = {
           let button = UIButton()
           button.backgroundColor = UIColor(named: "mainColor")
           button.setTitle("비밀번호 재설정하기", for: .normal)
           button.setTitleColor(.black, for: .normal)
           button.titleLabel?.font = UIFont.customFont(ofSize: 12, weight: .regular, fontName: "GowunDodum-Regular")
           button.layer.cornerRadius = 8
           return button
       }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupViews()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       
       //MARK: - SetAuthLayout
       func setupViews() {
           self.backgroundColor = .white
           translatesAutoresizingMaskIntoConstraints = false
           
           addSubview(scrollView)
           scrollView.addSubview(mainLabel)
           scrollView.addSubview(emailLabel)
           scrollView.addSubview(descriptionLabel)
           scrollView.addSubview(emailTextField)
           scrollView.addSubview(detailsLabel)
           scrollView.addSubview(resetPasswordButton)
       }
       
       override func layoutSubviews() {
           super.layoutSubviews()
           
           scrollView.frame = bounds
           
           let size = scrollView.width / 3
           mainLabel.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
           
           emailLabel.frame = CGRect(x: 16, y: mainLabel.bottom + 30, width: 60, height: 25)
           descriptionLabel.frame = CGRect(x: 16, y: emailLabel.bottom + 6, width: 250, height: 25)
           emailTextField.frame = CGRect(x: 16, y: descriptionLabel.bottom + 6, width: 361, height: 42)
           detailsLabel.frame = CGRect(x: 16, y: emailTextField.bottom + 6, width: 361, height: 42)
           resetPasswordButton.frame = CGRect(x: 16, y: detailsLabel.bottom + 50, width: 361, height: 42)
           
       }

}
