//
//  CustomAlertView.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/04/04.
//

import UIKit

final class CustomAlertView: UIView {
    
    // MARK: - Properties
    
    // 기준 날짜를 잡기 위한 속성
    private var date: Date
    
    var titleString: String?
    
    private var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.5
        
        return view
    }()
    
    // MARK: - 얼럿뷰 안에 들어갈 속성
    
    private var alertDate: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "03.28 (화)"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    // 일기
    private var alertDiary: UILabel = {
        let label = UILabel()
        label.text = "일기"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
     lazy var diaryTitleButton: UIButton = {
        let button = AlertTitleButton(type: .system)
        //button.setTitle("약과가 먹고싶은 날", for: .normal)
         button.setTitle(titleString ?? "", for: .normal)
//        button.addTarget(self, action: #selector(diaryTitleButtonTapped), for: .touchUpInside)
        return button
    }()
    private var diaryCircle: UILabel = {
        let label = UILabel()
        label.text = "●"
        label.textColor = UIColor(named: "subPurpleColor")
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    // 메모
    private var alertNote: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
     lazy var noteTitleButton: UIButton = {
        let button = AlertTitleButton(type: .system)
        button.setTitle("치과 4:30", for: .normal)
//        button.addTarget(self, action: #selector(noteTitleButtonTapped), for: .touchUpInside)
        return button
    }()
    private var noteCircle: UILabel = {
        let label = UILabel()
        label.text = "●"
        label.textColor = UIColor(named: "subPurpleColor")
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    // 시간차 일기
    private var alertLockedDiary: UILabel = {
        let label = UILabel()
        label.text = "일기"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
     lazy var lockedDiaryTitleButton: UIButton = {
        let button = AlertTitleButton(type: .system)
        button.setTitle("수박이 먹고싶은 날", for: .normal)
        return button
    }()
    private var lockedDiaryCircle: UILabel = {
        let label = UILabel()
        label.text = "●"
        label.textColor = UIColor(named: "subPinkColor")
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private var lockedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock.fill")
        imageView.tintColor = UIColor.black
        imageView.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        return imageView
    }()
    
    // + 버튼
     lazy var plusButton: UIButton = {
        let imageView = UIImageView()
         imageView.image = UIImage(systemName: "plus")
         imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.setImage(imageView.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    
    // MARK: - StackView
    private lazy var diaryStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [alertDiary, diaryTitleButton])
        sv.distribution = .fill
        sv.alignment = .leading
        sv.spacing = 4
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var noteStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [alertNote, noteTitleButton])
        sv.distribution = .fill
        sv.alignment = .leading
        sv.spacing = 4
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var lockedDiaryStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [alertLockedDiary, lockedDiaryTitleButton])
        sv.distribution = .fill
        sv.alignment = .leading
        sv.spacing = 4
        sv.axis = .vertical
        return sv
    }()
    
    
    // MARK: - Initializer
    
    init(date: Date,  title: String? = nil) {
        self.date = date
        self.titleString = title ?? "제목"
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 0.3)
        addSubview(alertView)
        setAlertView()
        setDateTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    private func setAlertView() {
        alertView.addSubview(alertDate)
        alertView.addSubview(diaryStack)
        alertView.addSubview(diaryCircle)
        alertView.addSubview(noteStack)
        alertView.addSubview(noteCircle)
        alertView.addSubview(lockedDiaryStack)
        alertView.addSubview(lockedDiaryCircle)
        alertView.addSubview(lockedImage)
        
        alertView.addSubview(plusButton)
  
        setAutolayout()
        plusButton.addDashedCircle()
    }
    
    private func setDateTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd (EEE)"
        alertDate.text = dateFormatter.string(from: date)
    }
    
    // MARK: - 오토레이아웃
    
    private func setAutolayout() {
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([alertView.centerXAnchor.constraint(equalTo: self.centerXAnchor), alertView.centerYAnchor.constraint(equalTo: self.centerYAnchor), alertView.widthAnchor.constraint(equalToConstant: 250), alertView.heightAnchor.constraint(equalToConstant: 314)])
        
        // 메인 날짜
        alertDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([alertDate.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 26), alertDate.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 24), alertDate.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: 135)])
        
        // 일기
        diaryStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([diaryStack.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 30),diaryStack.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: 30), diaryStack.topAnchor.constraint(equalTo: alertDate.bottomAnchor, constant: 17)])
        
        diaryCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([diaryCircle.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 16),
                                     diaryCircle.rightAnchor.constraint(equalTo: alertDiary.leftAnchor, constant: 6), diaryCircle.centerYAnchor.constraint(equalTo: alertDiary.centerYAnchor)])
        
        // 메모
        noteStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([noteStack.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 30),noteStack.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: 30), noteStack.topAnchor.constraint(equalTo: diaryStack.bottomAnchor, constant: 17)])
        
        noteCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([noteCircle.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 16),
                                     noteCircle.rightAnchor.constraint(equalTo: alertNote.leftAnchor, constant: 6), noteCircle.centerYAnchor.constraint(equalTo: alertNote.centerYAnchor)])
        
        // 시간차 일기
        lockedDiaryStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lockedDiaryStack.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 30), lockedDiaryStack.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: 30), lockedDiaryStack.topAnchor.constraint(equalTo: noteStack.bottomAnchor, constant: 17)])
        
        lockedDiaryCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lockedDiaryCircle.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 16),
            lockedDiaryCircle.rightAnchor.constraint(equalTo: alertLockedDiary.leftAnchor, constant: 6), lockedDiaryCircle.centerYAnchor.constraint(equalTo: alertLockedDiary.centerYAnchor)])
        
        lockedImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lockedImage.leftAnchor.constraint(equalTo: lockedDiaryTitleButton.rightAnchor, constant: 2), lockedImage.centerYAnchor.constraint(equalTo: lockedDiaryTitleButton.centerYAnchor)])
        
        // 추가 버튼
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([plusButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor), plusButton.widthAnchor.constraint(equalToConstant: 50), plusButton.heightAnchor.constraint(equalTo: plusButton.widthAnchor, multiplier: 1), plusButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -24)])
    }
    
    
}
