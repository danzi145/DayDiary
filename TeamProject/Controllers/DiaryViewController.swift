//
//  File.swift
//  TeamProject
//
//  Created by 박채운 on 2023/05/16.
//

import UIKit
import PhotosUI


final class DiaryViewController: UIViewController {
    
//    let diaryManager = DiaryCoreDataManager.shared
//
//    var diaryData: DiaryCoreData?
    
    
    
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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("여기에서 코어데이터에서 다시 제목 가져와서 표시")
//        // 코어데이터에서 제목 데이터 가져오기
//        let diaryData = DiaryCoreDataManager.shared
//
//        // 다시 표시 (예를 들어)
//        let customView = view as? DiaryView
//        customView?.titleTextField.text = diaryData.getDiaryListFromCoreData().first?.value(forKey: "dTitle") as? String
//        customView?.memoTextView.text = diaryData.getDiaryListFromCoreData().first?.value(forKey: "dContent") as? String
//
//    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNaviBar()
        setupTargetTapped()
        

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
    
    
    
    func setupTargetTapped() {
    // image picker
        diaryV.button1.addTarget(self, action: #selector(self.pickImage), for: .touchUpInside)
    //envelop
        diaryV.button0.addTarget(self, action: #selector(listTableViewAlert(_:)), for: .touchUpInside)
    //trash
        diaryV.button2.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }

    
    // MARK: - Custom Method

    
    func configUI() {
        
        view.backgroundColor = .white
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
    
    
    @objc func weatherButtonTapped() {
        print("날씨 버튼 눌림")
    }
    
  @objc func pickImage() {
        setupImagePicker()
        self.present(self.picker, animated: true) // Controller이기 때문에 present 메서드를 이용해서 컨트롤러 뷰를 띄워줌
    }
    
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
        self.navigationController?.popViewController(animated: true)
            let alert = UIAlertController(title: "", message: "저장되었습니다", preferredStyle: .alert)
            let success1 = UIAlertAction(title: "확인", style: .default) { [weak self] action in
            self?.mainButtonTapped()
            }
            alert.addAction(success1)
            self.present(alert, animated: true, completion: nil)

        
    }

        
        
        @objc func mainButtonTapped() {
            
            let vc = MonthlyViewController()
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
        
        @objc func listTableViewAlert(_ sender: UIButton) {
            
            //콘텐츠 뷰 영역
            let contentVc = ListTableTableViewController()
            
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
