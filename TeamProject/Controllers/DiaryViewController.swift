//
//  File.swift
//  TeamProject
//
//  Created by 박채운 on 2023/05/16.
//

import UIKit
import PhotosUI
import CoreData

final class DiaryViewController: UIViewController {
    
    let diaryManager = DiaryCoreDataManager.shared

    var diaryData: DiaryCoreData?
    
    
    var fetch = NSFetchRequestResultType()
    
    
    var date: String?
    var imageView = UIImageView()
    
    let picker = UIImagePickerController()
    
    private let diaryV = DiaryView()
    private let alertV = CustomAlertView(date: Date())
    
   // private let alertV = CustomAlertView(date: Date.now, title1)
    
    override func loadView() {
        super.loadView()
        view = diaryV
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("여기에서 코어데이터에서 다시 제목 가져와서 표시")
        // 코어데이터에서 제목 데이터 가져오기
        let diaryData = DiaryCoreDataManager.shared

        // 다시 표시 (예를 들어)
        let customView = view as? DiaryView
        customView?.titleTextField.text = diaryData.getDiaryListFromCoreData().first?.value(forKey: "dTitle") as? String
        customView?.memoTextView.text = diaryData.getDiaryListFromCoreData().first?.value(forKey: "dContent") as? String
        customView?.mainImageView.image = diaryData.getDiaryListFromCoreData().first?.value(forKey: "dPhoto") as? UIImage
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNaviBar()
        addTargetTapped()
        configUI()
        setupDelegate()
    }
    
    
    
    func setupDelegate() {
        
        diaryV.titleTextField.delegate = self
        
    }
    
    
    func setupNaviBar() {
        title = date
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.6571641564, green: 0.6571640372, blue: 0.6571640372, alpha: 1)]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemGray2
    }
    
    
    func configureDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko-KR") // 한국 시간 지정
        dateFormatter.timeZone = TimeZone(abbreviation: "KST") // 한국 시간대 지정
        
        return dateFormatter.string(from: date)
    }
    
    // image picker
    
    //버튼 타겟
    func addTargetTapped() {
        diaryV.button1.addTarget(self, action: #selector(self.pickImage), for: .touchUpInside)
    //envelop
        diaryV.button0.addTarget(self, action: #selector(listTableViewAlert(_:)), for: .touchUpInside)
    //trash
        diaryV.button2.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }

    
    func configUI() {
        
        view.backgroundColor = .white
    }
    
    
    
  @objc func pickImage() {
        setupImagePicker()
        self.present(self.picker, animated: true) // Controller이기 때문에 present 메서드를 이용해서 컨트롤러 뷰를 띄워줌
    }
    func setupImagePicker() {
        // 기본설정 셋팅
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .videos])
        
        // 기본설정을 가지고, 피커뷰컨트롤러 생성
        let picker = PHPickerViewController(configuration: configuration)
        // 피커뷰 컨트롤러의 대리자 설정
        picker.delegate = self
        // 피커뷰 띄우기
        self.present(picker, animated: true, completion: nil)
    }
    
    // MARK: -  button(UIImage: Trash)
    @objc func resetButtonTapped() {
        
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: "삭제한 일기는 복구되지 않습니다.", preferredStyle: .alert)
        let success1 = UIAlertAction(title: "삭제", style: .default) { [weak self] action in
            self?.mainButtonTapped()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소버튼이 눌렸습니다.")
        }
        alert.addAction(success1)
        
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @objc func saveButtonTapped() {
        guard let memo = diaryV.titleTextField.text, memo.count > 0 else {
            alertSave(message:"제목을 입력하세요")
            return }
        
        if let diarydata = self.diaryData {
            diarydata.dTitle = diaryV.titleTextField.text
            diarydata.dContent = diaryV.memoTextView.text
            diarydata.dPhoto = diaryV.mainImageView.image?.jpegData(compressionQuality: 1)

            diaryManager.updateDiary(newDiaryCoreData: diarydata) {
                print("update 완료")
                self.navigationController?.popViewController(animated: false)
            }
        } else {
            let title = diaryV.titleTextField.text
            let content = diaryV.memoTextView.text
            let photo = diaryV.mainImageView.image?.jpegData(compressionQuality: 1)
            diaryManager.saveDiaryData(dtitle: title, dcontent: content, dphoto: photo) {
                print("save 완료")
                let alert = UIAlertController(title: "", message: "저장되었습니다", preferredStyle: .alert)
                let success1 = UIAlertAction(title: "확인", style: .default) { [weak self] action in self?.mainButtonTapped()
                    
                }
                alert.addAction(success1)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }

        
        @objc func mainButtonTapped() {
            let vc = MonthlyViewController()
            vc.modalPresentationStyle = .fullScreen
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
        
        @objc func listTableViewAlert(_ sender: UIButton) {
            
            //콘텐츠 뷰 영역
            let contentVc = ListTableViewController()
            
            //델리게이트 설정
            contentVc.delegate = self
            
            let alertA = UIAlertController(title: "열어볼 날짜를 선택하세요!", message: "선택한 날짜 이전에 열어볼 수 없으니 신중히 선택하세요!", preferredStyle: .alert)
            
            //버튼 정의
            let okAction = UIAlertAction(title: "확인", style: .default) { action in
            }
            let cancelAction = UIAlertAction(title:"취소", style: .cancel) { action in }
            
            //버튼을 알림창에 추가
            alertA.addAction(okAction)
            alertA.addAction(cancelAction)
            //알림창의 콘텐츠 뷰 컨트롤러 속성에 등록
            alertA.setValue(contentVc, forKey: "contentViewController")
            
            self.present(alertA, animated: true, completion: nil)
        }
        func didSelectedRowAt(indexPath:IndexPath) {
            
            print("\(indexPath.row)")
            
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    } //- 클래스 끝
    
    
    

    //    // MARK: 키보드 나올 때, main screen up
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
    
    
    //extension UITextField {
    //
    //
    //    func setDatePicker(target: Any, selector: Selector) {
    //        let SCwidth = self.bounds.width
    //        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: SCwidth, height: 216))
    //        datePicker.datePickerMode = .date
    //        self.inputView = datePicker
    //
    //        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: SCwidth, height: 44.0))
    //        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    //        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
    //        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
    //        toolBar.setItems([cancel, flexible, barButton], animated: false)
    //        self.inputAccessoryView = toolBar
    //
    //    }
    //    @objc func tapCancel() {
    //        self.resignFirstResponder()
    //    }
    //
    //
    //}

    //extension ViewController {
    //
    //    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    //        var newImage: UIImage? = nil
    //
    //        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage { // 수정된 이미지가 있을 경우
    //            newImage = possibleImage
    //        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage { // 오리지널 이미지가 있을 경우
    //            newImage = possibleImage
    //        }
    //
    //        imageView.image = newImage // 받아온 이미지를 이미지 뷰에 넣어준다.
    //
    //        picker.dismiss(animated: true) // 그리고 picker를 닫아준다.
    //        picker.delegate = self
    //
    //
    //    }
    //
    //}
    extension DiaryViewController: PHPickerViewControllerDelegate {
        
        // 사진이 선택이 된 후에 호출되는 메서드
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // 피커뷰 dismiss
            picker.dismiss(animated: true)
            
            let itemProvider = results.first?.itemProvider
            
            if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async {
                        // 이미지뷰에 표시
                        self.diaryV.mainImageView.image = image as? UIImage
                        self.diaryV.mainImageView2.image = image as? UIImage
                    }
                }
            } else {
                print("error")
            }
        }
    }


// 저장버튼 눌렸을 때 제목입력안하면 발생하는 alert
extension UIViewController {
        func alertSave(title:String = "알림", message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }

extension DiaryViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if diaryV.titleTextField.text != "" {
            navigationItem.rightBarButtonItem?.tintColor = .black
        } else {
            navigationItem.rightBarButtonItem?.tintColor = .systemGray2
        }
    
    }
}
