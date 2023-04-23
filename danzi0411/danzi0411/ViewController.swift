//
//  ViewController.swift
//  danzi0411
//
//  Created by 박채운 on 2023/04/01.
//

import UIKit
import SnapKit
import Then
import Photos
import UserNotifications


class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // MARK: - Properties
    
    
    var imageView = UIImageView()
        // storyboard에서 만들지 않았기 때문에 type을 명시해줘야 한다.
        var button4 = UIButton(type: .system)
    let picker = UIImagePickerController()
    
    
    private let datePicker = UIDatePicker()
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    func callNotification(seconds: Double, title : String, body : String) {
            let notificationContent = UNMutableNotificationContent()

            notificationContent.title = title
            notificationContent.body = body

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
            let request = UNNotificationRequest(identifier: "Notification",
                                                content: notificationContent,
                                                trigger: trigger)

            userNotificationCenter.add(request) { error in
                if let error = error {
                    print("Error: ", error)
                }
            }
        }
    
//    private lazy var scrollView = UIScrollView()
//        private lazy var contentView = UIView()
//        private lazy var titleLabel = UILabel()
//        private lazy var previousButton = UIButton()
//        private lazy var nextButton = UIButton()
//        private lazy var todayButton = UIButton()
//        private lazy var weekStackView = UIStackView()
//        private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    
    
    
    
    
    convenience init(title: String, bgColor: UIColor) {
        self.init()
        
    }
    
    let placeholder2 = "제목"
    let placeholder = "내용"
    let activityTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 14)
        $0.layer.cornerRadius = 1
        $0.backgroundColor = .white
        $0.tintColor = .systemYellow
        $0.textContainerInset = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
    }
//    private lazy var stackView: UIStackView = {
//        let stview = UIStackView(arrangedSubviews: [titleTextView, activityTextView ])
//        stview.spacing = 18
//        stview.axis = .vertical
//        stview.distribution = .fillEqually
//        stview.alignment = .fill
//        return stview
//    }()
    let activityTextView2 = UITextView().then {
        $0.font = .systemFont(ofSize: 20)
        $0.layer.cornerRadius = 1
        $0.backgroundColor = .white
        $0.tintColor = .systemYellow
        $0.textContainerInset = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
    }
    
    let letterNumLabel = UILabel().then {
        $0.text = "0/150"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .gray
        $0.textAlignment = .right
    }
    

    
    
    
    
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ko_KR")
        dateformatter.timeZone = TimeZone(identifier: "KST")
        dateformatter.dateFormat = "yyyy-MMMM-dd E"
        print(dateformatter.string(from: Date()))  //2021-4월-10 토
        dateformatter.dateFormat = "yyyy년 MMMM dd일 E요일 "
        dateformatter.amSymbol = "오전"
        dateformatter.pmSymbol = "오후"
        print(dateformatter.string(from: Date())) // 2021-4월-10 토 오후 1:54:20
        
        let label = UILabel(frame: CGRect(x:100, y:100, width:100, height:110))
        
        super.viewDidLoad()
        label.text = "\(dateformatter.string(from: Date()))"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit ()
        label.center.x = self.view.frame.width / 2
        view.addSubview(label)
        
        
        
        
        // MARK: imageView
        
        
        self.imageView.frame = CGRect(x: 55, y: 55, width: UIScreen.main.bounds.size.width, height: 50)
                self.imageView.backgroundColor = .gray
                
                // 버튼의 크기와 title을 설정하고 버튼을 누르면 pickImage 함수가 호출된다.
                self.button4.frame = CGRect(x: 93, y: 771, width: 40, height: 33)
                self.button4.setTitle("", for: .normal)
        self.button4.setImage(UIImage(systemName: "rectangle.and.paperclip"), for: .normal)
                self.button4.titleLabel?.textAlignment = .center
                self.button4.addTarget(self, action: #selector(self.pickImage), for: .touchUpInside)
        self.button4.contentVerticalAlignment = .fill
        self.button4.contentHorizontalAlignment = .fill
                self.view.addSubview(self.imageView)
                self.view.addSubview(self.button4)
                
                self.picker.sourceType = .photoLibrary // 방식 선택. 앨범에서 가져오는걸로 선택.
                self.picker.allowsEditing = false // 수정가능하게 할지 선택. 하지만 false
                self.picker.delegate = self // picker delegate
        let button = UIButton(frame: CGRect(x:100, y:760, width:40, height:40))
       
        button.backgroundColor = .white
        button.setTitle("저장", for: .normal)
        button.layer.borderWidth = 0
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.center.x = self.view.frame.width / 1.15
        view.addSubview(button)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        var config = UIButton.Configuration.filled()
        let button2 = UIButton(frame: CGRect(x:60, y:350, width:70, height:70))
        button2.layer.frame = CGRect(x:-200, y:90, width:40, height:30)
        view.addSubview(button2)
        button2.backgroundColor = .white
        button2.setImage(UIImage(systemName: "xmark"), for: .normal)
        

        config.image = UIImage(systemName: "rectangle.and.paperclip")
        config.buttonSize = .small
        button2.setTitleColor(.black, for: .normal)
        button2.center.x = self.view.frame.width / 1.1

        
        let button3 = UIButton(frame: CGRect(x:130, y:750, width:70, height:70))
        button3.layer.frame = CGRect(x:120, y:773, width:40, height:30)
       
        
        button3.backgroundColor = .white
        button3.setImage(UIImage(systemName: "envelope"), for: .normal)
        button3.backgroundColor = .white
        button3.contentVerticalAlignment = .fill
        button3.contentHorizontalAlignment = .fill
        button3.setTitleColor(.black, for: .normal)
        button3.center.x = self.view.frame.width / 7
        view.addSubview(button3)
        self.view.bringSubviewToFront(imageView)
//                //네모 타입 버튼
//                let rectBtn = CSButton(type: .rect)
//                rectBtn.frame = CGRect(x: 30, y: 100, width: 150, height: 30)
//                self.view.addSubview(rectBtn)
//
//                //둥근 버튼
//                let circleBtn = CSButton(type: .circle)
//                circleBtn.frame = CGRect(x: 100, y: 150, width: 150, height: 30)
//                self.view.addSubview(circleBtn)
//
        view.addSubview(imageView)
        
        self.view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
                    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 100),
                    imageView.heightAnchor.constraint(equalToConstant: 130),
                    
                ])
        configUI()
        setupAutoLayout()
        setupTextView()
        
//        let toolbar = UIToolbar(frame: CGRect(x:100, y:100, width: self.view.frame.size.width, height: 30))
        let toolbar = UIToolbar()
       // let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done))
        let customBtn = UIBarButtonItem(title: "저장", style: .plain, target: nil, action: nil)
       
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.tintColor = .black
        toolbar.sizeToFit()

        toolbar.setItems([customBtn, flexibleSpaceButton], animated: false)
       activityTextView.inputAccessoryView = toolbar

    }
    
    
    @objc func resetButtonTapped() {
        
        let alert = UIAlertController(title: "열어보고 싶은 날짜를 정해보세요!", message: "그 전까지는 확인할 수 없으니 신중하게 선택하세요👀", preferredStyle: .alert)
        let success1 = UIAlertAction(title: "하나", style: .default) { action in
            print("gggggggggggg")
        }
        let success = UIAlertAction(title: "둘", style: .default) { action in
            print("확인버튼이 눌렸습니다.")
        }
        let cancel = UIAlertAction(title: "셋", style: .cancel) { action in
            print("취소버튼이 눌렸습니다.")
        }
        alert.addAction(success1)
        alert.addAction(success)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    // 앱의 화면을 터치하면 동작하는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    
    
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .white
    }
    
    func setupAutoLayout() {
        view.addSubview(activityTextView)
        view.addSubview(activityTextView2)
        view.addSubview(letterNumLabel)
        view.addSubview(imageView)
        
        activityTextView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
            make.height.equalTo(500)
            make.width.equalTo(380)
            
            
            
            
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(300).offset(390)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-150)
            make.height.equalTo(110)
            make.width.equalToSuperview().multipliedBy(0.6)
            
            
            
            
        }
        
        letterNumLabel.snp.makeConstraints { make in
            make.top.equalTo(activityTextView.snp.bottom).offset(6)
            make.trailing.equalToSuperview().inset(28)
        }
        activityTextView2.snp.makeConstraints { make in
            make.bottom.equalTo(activityTextView.snp.top).offset(0)
            make.top.equalTo(150)
            make.centerX.equalToSuperview()
        
            make.height.equalTo(10)
            make.width.equalTo(380)
            
        }
    }
    
    func setupTextView() {
        activityTextView.delegate = self
        activityTextView.text = placeholder /// 초반 placeholder 생성
        activityTextView.textColor = .gray
        activityTextView2.delegate = self
        activityTextView2.text = placeholder2 /// 초반 placeholder 생성
        activityTextView2.textColor = .gray/// 초반 placeholder 색상 설정
    }
  
    
    
    
    @objc func pickImage() {
            self.present(self.picker, animated: true) // Controller이기 때문에 present 메서드를 이용해서 컨트롤러 뷰를 띄워줌
        }
   
    
} //- 클래스 끝




extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        /// 텍스트뷰 입력 시 테두리 생기게 하기
        activityTextView.layer.borderWidth = 1
        activityTextView.layer.borderColor = UIColor.white.cgColor
        activityTextView2.layer.borderWidth = 1
        activityTextView2.layer.borderColor = UIColor.white.cgColor
        /// 플레이스홀더
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            activityTextView.textColor = .gray
            activityTextView.text = placeholder
        } else if textView.text == placeholder {
            activityTextView.textColor = .black
            activityTextView.text = nil
        }
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            activityTextView2.textColor = .gray
            activityTextView2.text = placeholder2
        } else if textView.text == placeholder2 {
            activityTextView2.textColor = .black
            activityTextView2.text = nil
        }
        
    }
    
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        /// 글자 수 제한
        if activityTextView.text.count > 150 {
            activityTextView.deleteBackward()
        }
        if activityTextView2.text.count > 30 {
            activityTextView2.deleteBackward()
        }
        
        /// 아래 글자 수 표시되게 하기
        letterNumLabel.text = "\(activityTextView.text.count)/300"
       
        /// 글자 수 부분 색상 변경
        let attributedString = NSMutableAttributedString(string: "\(activityTextView.text.count)/300")
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: ("\(activityTextView.text.count)/300" as NSString).range(of:"\(activityTextView.text.count)"))
        letterNumLabel.attributedText = attributedString
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        /// 텍스트뷰 입력 완료시 테두리 없애기
        activityTextView.layer.borderWidth = 1
        activityTextView2.layer.borderWidth = 1
        /// 플레이스홀더
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
            activityTextView.textColor = .gray
            activityTextView.text = placeholder
            letterNumLabel.textColor = .gray /// 텍스트 개수가 0일 경우에는 글자 수 표시 색상이 모두 gray 색이게 설정
            letterNumLabel.text = "0/300"
        }
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder2 {
            activityTextView2.textColor = .gray
            activityTextView2.text = placeholder2
            
        }
        
    }
    
    
    
   
    
    
    
    
    
    
    
//    // MARK: main screen up
//    override func viewWillAppear(_ animated: Bool) {
//        // 옵져버를 등록
//        // 옵저버 대상 self
//        // 옵져버 감지시 실행 함수
//        // 옵져버가 감지할 것
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    @objc func keyboardUp(notification:NSNotification) {
//        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//           let keyboardRectangle = keyboardFrame.cgRectValue
//
//            UIView.animate(
//                withDuration: 0.3
//                , animations: {
//                    self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
//                }
//            )
//        }
//    }
//    @objc func keyboardDown() {
//        self.view.transform = .identity
 //   }
}

extension UITextField {
    
    
    func setDatePicker(target: Any, selector: Selector) {
        let SCwidth = self.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: SCwidth, height: 216))
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: SCwidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
        
    }
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
    
}

extension ViewController {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage? = nil
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage { // 수정된 이미지가 있을 경우
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage { // 오리지널 이미지가 있을 경우
            newImage = possibleImage
        }
        
        imageView.image = newImage // 받아온 이미지를 이미지 뷰에 넣어준다.
        
        picker.dismiss(animated: true) // 그리고 picker를 닫아준다.
    }
    
}
