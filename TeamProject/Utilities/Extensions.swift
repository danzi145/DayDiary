//
//  Extensions.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/04/23.
//

import UIKit

// 동그란 레이어를 만들기 위한 UIView 확장
extension UIView {
    func addDashedCircle() {
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleLayer.lineWidth = 2.0
        circleLayer.strokeColor =  UIColor.black.cgColor //border of circle
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineJoin = .round
        circleLayer.lineDashPattern = [4,2]
        layer.addSublayer(circleLayer)
    }
}




