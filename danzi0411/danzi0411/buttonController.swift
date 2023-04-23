////
////  buttonController.swift
////  danzi0411
////
////  Created by 박채운 on 2023/04/11.
////
import Foundation
import UIKit
//
class buttonController: UIViewController {
    //
    private lazy var passwordResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //    let photoButton = UIButton(frame: .zero) //1 버튼 위치 및 크기는 addConstraints()에서 알아서 설정하기
    //    var imageView = UIImageView()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupViews()
        //        addConstraints()
    }
    @objc func resetButtonTapped() {
        //만들기
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인버튼이 눌렸습니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소버튼이 눌렸습니다.")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        // 실제 띄우기
        self.present(alert, animated: true, completion: nil)
    }
}
//
//    func setupViews() {
//        photoButton.setTitle("사진", for: .normal)
//        photoButton.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside) //2
//
//        view.addSubview(imageView)
//        view.addSubview(photoButton)
//        view.subviews.forEach { view in
//            view.translatesAutoresizingMaskIntoConstraints = false
//            view.sizeToFit()
//        }
//    }
//
//    func addConstraints() {
//        let safeArea = view.safeAreaLayoutGuide
//        NSLayoutConstraint.activate([
//            // 버튼과 imageView의 위치 및 크기 설정
//            imageView.heightAnchor.constraint(equalTo: view.heightAnchor),
//            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//    }
//    //2
//    @objc func uploadPhoto() {
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.delegate = self //3
//        // imagePicker.allowsEditing = true
//        present(imagePicker, animated: true)
//    }
//}
//
////3
//extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = pickedImage //4
//        }
//        dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//}
