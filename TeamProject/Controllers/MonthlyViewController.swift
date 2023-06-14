//
//  ViewController.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/03/29.
//

import UIKit
import FSCalendar
import FirebaseAuth
import GoogleSignIn
import CoreLocation

// MARK: - Object
protocol MonthlyViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

final class MonthlyViewController: UIViewController, UINavigationControllerDelegate {
    
    let topStackView = MonthlyNavigationStackView()
    private let calendarView = CalendarView()
    
    private let locationManager = LocationManager.shared
//    let memoManager = MemoManager.shared
    
    weak var delegate: MonthlyViewControllerDelegate?
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setCalendar()
        setupAddTarget()
        setLocationManager()
        
        // 날씨 네트워킹 체크를 위한 제스처 추가
        topStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getWeatherData)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    // 날씨 네트워킹 테스트에 사용되는 action
    @objc private func getWeatherData() {
        print("네트워킹을 통해 날씨 데이터 받기")
        // 현재 위치 좌표 확인
        print(UserDefaultsManager.shared.currentCoordinate)
        
        // 현재 위치 기준 날씨 데이터 받기
        let coordinate = UserDefaultsManager.shared.currentCoordinate
        WeatherNetworkingManager.shared.getWeatherData(coordinate: coordinate) { weather in
            print(weather)
        }
    }
    
    
    // MARK: - Helper
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        // 네비게이션 백 버튼
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        
        let mainStack = UIStackView(arrangedSubviews: [topStackView, calendarView])
        mainStack.axis = .vertical
        
        view.addSubview(mainStack)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor), mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor), mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = .init(top: -30, left: 0, bottom: 0, right: 0)
        mainStack.bringSubviewToFront(topStackView)
    }
    
    private func setCalendar() {
        calendarView.calendarView.delegate = self
        calendarView.calendarView.dataSource = self
    }
    
    private func setupAddTarget() {
        topStackView.menuButton.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
    }
    
//    private func handleNotAuthenticated() {
//        // Check auth status (유저 로그인 유무 확인)
//        if Auth.auth().currentUser == nil {
//            // 로그인 화면 보여주기
//            let loginVC = MultiAuthViewController()
//            loginVC.modalPresentationStyle = .fullScreen
//            present(loginVC, animated: false)
//        }
//    }
    
    private func handleNotAuthenticated() {
        // Check auth status
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, appDelegate.isAuthenticated {
            // User is authenticated, proceed with the app
        } else {
            // User is not authenticated, present login view controller
            let loginVC = MultiAuthViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
    
    // 위치 사용 권한 허용 체크 및 locationManager 세팅
    private func setLocationManager() {
        LocationManager.shared.delegate = self
        LocationManager.shared.desiredAccuracy = kCLLocationAccuracyBest  // 배터리 최적화
        if LocationManager.shared.authorizationStatus != .authorizedAlways || LocationManager.shared.authorizationStatus != .authorizedWhenInUse {
            LocationManager.shared.requestWhenInUseAuthorization()
        }
        
        DispatchQueue.global(qos: .background).async {
            guard LocationManager.shared.location?.coordinate != nil
                else {
                print("location update 아직 안된 상태")
                return
            }
        }
    }

    // 사용자의 환경설정 - 위치 허용으로 안내
    private func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let presentSettings = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(presentSettings)
        
        present(requestLocationServiceAlert, animated: true)
    }
    
    private func setAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let diary = UIAlertAction(title: "일기", style: .default) { [weak self] action in
            print("확인버튼 눌림.")
            let diaryVC = DiaryViewController()
            
            guard let selectDate = self?.calendarView.calendarView.selectedDate else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            
            let date = dateFormatter.string(from: selectDate)
            diaryVC.date = date
            self?.navigationController?.pushViewController(diaryVC, animated: true)
        
    
        }
        let memo = UIAlertAction(title: "메모", style: .default) { [weak self] action in
            print("확인버튼 눌림.")
            
            let memoVC = MemoViewController()
            
            guard let selectDate = self?.calendarView.calendarView.selectedDate else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            
            let date = dateFormatter.string(from: selectDate)
            memoVC.date = date
//            let memo = Memo(saveButton: false, date: date, title: nil, contents: nil, checkList: [Memo.Check(isCheck: false, textField: "")])
//            self.memoManager.memoArray.append(memo)
            self?.navigationController?.pushViewController(memoVC, animated: true)
        }
        
        let cancel = UIAlertAction(title: "취소하기", style: .cancel) { [weak self] action in
            print("취소버튼 눌림.")
            self?.calendarView.calendarView.setCurrentPage(Date(), animated: true)
        }
        alert.addAction(diary)
        alert.addAction(memo)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func setCustomAlert(date: Date) {
            let customAlert = CustomAlertViewController(baseDate: date)
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(customAlert, animated: true, completion: nil)
        }
    
    // MARK: - Actions
    @objc private func menuTapped() {
        let vc = SettingsListViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: - FSCalendarDelegate

extension MonthlyViewController: FSCalendarDelegate, FSCalendarDataSource,  FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print(dateFormatter.string(from: date) + " 선택됨")
        // 오늘 날짜 선택되지 않은 경우에만 alert 띄우기
        if dateFormatter.string(from: date) == dateFormatter.string(from: Date()) {
            print("오늘 선택됨")
            setCustomAlert(date: date)
        } else {
            setAlert()
        }
    }
    
    // 오늘 날짜에만 '오늘' 표시
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        switch dateFormatter.string(from: date) {
        case dateFormatter.string(from: Date()):
            return "오늘"
        default:
            return nil
        }
    }
    
    // 캘린더 넘길 때마다, navigationBar의 연도.월 바꾸기
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentDate = calendarView.calendarView.currentPage
        topStackView.baseDate = currentDate
    }
    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let dateString = dateFormatter.string(from: date)
//        let eventImage = UIImage(systemName: "circle.fill")?.withTintColor(UIColor(named: "subPurpleColor")!)
//        print("date : \(dateString)")
//        return scheduleDateArray.contains(dateString) ? eventImage : nil
//        }
//
}

 
// MARK: - CLLocationManagerDelegate

extension MonthlyViewController: CLLocationManagerDelegate {
    
    // 권한설정 변경된 경우 실행
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한설정 허용됨")
            LocationManager.shared.startUpdatingLocation()
            
        case .restricted, .notDetermined:
            print("GPS 권한설정 X")
            LocationManager.shared.requestWhenInUseAuthorization()
            
        case .denied:
            print("GPS 권한설정 거부됨")
            showRequestLocationServiceAlert()
        default:
            print("요청")
        }
    }
    
    // 위치 업데이트 된 경우 실행
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        UserDefaultsManager.shared.setCurrentLocation(lon: currentLocation.coordinate.longitude,
                                                      lat: currentLocation.coordinate.latitude)
    }
    
}
