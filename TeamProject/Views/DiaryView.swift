//
//  DiaryView.swift
//  TeamProject
//
//  Created by 박채운 on 2023/05/16.
//
import UIKit




class DiaryView: UIView {
    
   
//    var diaryData: DiaryCoreData? {
//        didSet {
//            //configDataUI()
//            guard diaryData != nil else {
//                self.titleTextField.text = diaryData?.dTitle
//                self.memoTextView.text = diaryData?.dContent
//           return }
//
//            titleTextField.text = diaryData?.dTitle
//            memoTextView.text = diaryData?.dContent
//
//        }
//    }

     //MARK: - 텍스트 바뀌면 저장

    
    
//    let dateformatter: UILabel = {
//        let df = UILabel()
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "yyyy년 MMMM dd일 E요일 "
//        df.textColor = .gray
//        let exactlyCurrentTime: Date = Date()
//        print(dateFormatterPrint.string(from: exactlyCurrentTime))
//        df.text = "\((dateFormatterPrint.string(from: exactlyCurrentTime)))"
//        df.translatesAutoresizingMaskIntoConstraints = false
//        return df
//    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColor")
        
        view.clipsToBounds = true
        view.addSubview(titleTextField)
        //view.addSubview(titleInfoLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    var titleTextField: UITextField = {
        let tf = UITextField()
        
        tf.borderStyle = .none
        
        tf.backgroundColor = .white
        tf.font = UIFont.systemFont(ofSize: 20)

        tf.clearsOnBeginEditing = false
        tf.placeholder = "제목"
        
        tf.tintColor = .systemYellow
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    
    private lazy var memoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(memoTextView)
        view.addSubview(mainImageView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var memoTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.backgroundColor = .white
        textView.tintColor = .systemYellow
        textView.textColor = .lightGray
//        textView.layer.borderColor = UIColor.systemGreen.cgColor
//        textView.layer.borderWidth = 1
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.text = "내용"
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - 이미지 미리보기
    
    lazy var textStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [titleView,memoView])
                stview.spacing = 10
                stview.axis = .vertical
                stview.distribution = .fill
                stview.alignment = .fill
                stview.translatesAutoresizingMaskIntoConstraints = false
                return stview
    }()
    
    
    
    let button0: UIButton = {
//        let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .bold, scale: .large)
//        let largeSF = UIImage(systemName: "envelop", withConfiguration: config)
        let bt = UIButton(type: .custom)
        bt.backgroundColor = .white
        bt.setImage(systemName: "envelope")
        bt.setTitleColor(.white, for: .normal)
        
        bt.frame.size.height = 40
        bt.frame.size.width = 40
        bt.tintColor = .black
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let button1: UIButton = {
        let bt = UIButton(type: .custom)
        bt.backgroundColor = .white
        bt.setImage(systemName: "rectangle.and.paperclip")
        //bt.setImage(UIImage(systemName: "rectangle.and.paperclip"), for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.frame.size.height = 40
        bt.frame.size.width = 40
        bt.tintColor = .black
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    //MARK: - 이미지 미리보기
    let mainImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        imageView.clipsToBounds = true
        imageView.isOpaque = false
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let button2: UIButton = {
        let bt = UIButton(type: .custom)
        bt.backgroundColor = .white
        bt.setImage(systemName: "trash")
        bt.setTitleColor(.white, for: .normal)
        bt.frame.size.height = 40
        bt.frame.size.width = 40
        bt.tintColor = .black
        bt.translatesAutoresizingMaskIntoConstraints = false
       
        return bt
    }()
    lazy var buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        
        view.addSubview(button0)
        view.addSubview(button1)
        view.addSubview(button2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
                
    }()
    
    
    
    


    override init(frame:CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        
        
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//    private let titleViewHeight: CGFloat = 45
//    private let memoViewHeight: CGFloat = 230

    
    // MARK: - 오토레이아웃
    func setAutoLayout() {
        self.addSubview(titleView)
        self.addSubview(memoView)
        self.addSubview(buttonView)
        self.addSubview(textStackView)

        self.addSubview(mainImageView2)
 
        

        NSLayoutConstraint.activate([
            
            
            mainImageView.bottomAnchor.constraint(equalTo: memoView.bottomAnchor, constant: -20),
//            mainImageView.centerYAnchor.constraint(equalTo: memoView.centerYAnchor),
            mainImageView.centerXAnchor.constraint(equalTo: memoView.centerXAnchor),
      
            mainImageView.heightAnchor.constraint(equalToConstant: 300),
            mainImageView.widthAnchor.constraint(equalToConstant: 300),
       
            
            mainImageView2.bottomAnchor.constraint(equalTo: button1.bottomAnchor),
//            mainImageView.centerYAnchor.constraint(equalTo: memoView.centerYAnchor),
            mainImageView2.centerXAnchor.constraint(equalTo: button1.centerXAnchor),
      
            mainImageView2.heightAnchor.constraint(equalTo: button1.heightAnchor),
            mainImageView2.widthAnchor.constraint(equalTo: button1.widthAnchor),
        
//
        
            titleView.bottomAnchor.constraint(equalTo: memoView.topAnchor, constant: -10),
            titleView.heightAnchor.constraint(equalToConstant: 40),
        
        
            titleTextField.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
        
        

        
            textStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textStackView.heightAnchor.constraint(equalToConstant: 630),
        
            
            
        
        
            buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            buttonView.topAnchor.constraint(equalTo: textStackView.bottomAnchor, constant: 40),
            buttonView.heightAnchor.constraint(equalToConstant: 50),
       
            memoTextView.leadingAnchor.constraint(equalTo: memoView.leadingAnchor),
            memoTextView.trailingAnchor.constraint(equalTo: memoView.trailingAnchor),
            memoTextView.topAnchor.constraint(equalTo: memoView.topAnchor),
            memoTextView.bottomAnchor.constraint(equalTo: memoView.bottomAnchor),
            
        
       
            button0.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 10),
            button0.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 10),
            button0.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -10),
            button0.widthAnchor.constraint(equalToConstant: 35),
            
            
            button1.leadingAnchor.constraint(equalTo: button0.trailingAnchor, constant: 20),
            button1.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 10),
            button1.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -10),
            button1.widthAnchor.constraint(equalToConstant: 35),
            
            
            button2.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -20),
            button2.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 10),
            button2.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -10),
            button2.widthAnchor.constraint(equalToConstant: 35)
           
            ])
        
        

    }
    
}


extension UIButton {
    func setImage(systemName: String) {
        // 가로, 세로 정렬
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        // 이미지를 꽉차게 만듬
        imageView?.contentMode = .scaleAspectFit
        // 기존 setImage 메소드
        setImage(UIImage(systemName: systemName), for: .normal)
    }
}


extension DiaryView: UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "내용" {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "내용"
            textView.textColor = .lightGray
        }
    }
}
