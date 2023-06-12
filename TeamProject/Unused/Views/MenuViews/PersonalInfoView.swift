//
//  PersonalInfoView.swift
//  TeamProject
//
//  Created by 남현준 on 2023/04/28.
//

import UIKit

class PersonalInfoView: UIView {
    
    // MARK: - 개인정보처리방침 텍스트 레이블
    private let informationString: UILabel = {
        var label = UILabel()
        label.text = "피에 설산에서 뜨거운지라, 무엇이 풀이 소담스러운 만천하의 사는가 설레는 교향악이다. 싹이 것은 위하여, 온갖 하였으며, 주는 이 같지 커다란 말이다. 열락의 것이다.보라, 소금이라 찾아 예가 그들은 동력은 그들의 밥을 부패뿐이다. 가슴에 새 두손을 봄날의 이성은 밥을 투명하되 동산에는 것이다. 희망의 품었기 대중을 그러므로 없는 방황하였으며, 보이는 것이다. 목숨을 있을 끓는 보배를 방황하였으며, 것이다.보라, 긴지라 것은 무엇을 사막이다. 살 어디 작고 그들의 생생하며, 보라. 영원히 가슴에 뼈 생생하며, 모래뿐일 실현에 하여도 옷을 것이다. 것은 귀는 그것을 대고, 같지 것이다. 황금시대의 노래하며 유소년에게서 인생의 이상, 가치를 아니다.인간에 끝에 우리의 할지니, 뿐이다. 황금시대의 투명하되 있을 주며, 황금시대다"
        label.font = UIFont.systemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutoLayout() {
        backgroundColor = UIColor.white
        addSubview(informationString)
        
        informationString.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            informationString.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            informationString.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            informationString.widthAnchor.constraint(equalToConstant: 361),

        ])
        
    }
    
    
}

