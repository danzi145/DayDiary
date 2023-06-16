//
//  File.swift
//  TeamProject
//
//  Created by 박채운 on 2023/05/16.
//
import UIKit

class ListTableViewController: UITableViewController {

    /*
     델리게이트 객체로 사용할 변수를 정의
     사용자가 목록을 클릭하면 알림창을 띄우는 클래스에게 알려줘야 하는데
     둘 사이에는 참조할 수 있는 방법이 없기 때문에 호출할 수 있도록 객체 참조 정보를 이 변수에 저장.
     */
    var delegate : DiaryViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //높이
        self.preferredContentSize.height = 110
        
    }

    // MARK: - 테이블 뷰 셀


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 13
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row) 개월 뒤 "
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return cell
    }
    

    //선택 델리게이트 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //ViewController 클래스의 didSelectedRowAt 메소드 호출
        self.delegate?.didSelectedRowAt(indexPath: indexPath)
    }
    
}
