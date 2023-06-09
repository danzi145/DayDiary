//
//  UserDefaultsManager.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/06/09.
//

import Foundation

struct Coordinate {
    // 위도
    var longtitude: Double
    // 경도
    var latitude: Double
}

struct UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    /// 저장된 현재 위치 좌표 받기
    var currentCoordinate: Coordinate {
        let lon = UserDefaults.standard.object(forKey: "currentLongtitude") as! Double
        let lat = UserDefaults.standard.object(forKey: "currentLatitude") as! Double
        
        return Coordinate(longtitude: lon, latitude: lat)
    }
    
    /// 현재 위치 좌표를 UserDefaults에 저장하기
    func setCurrentLocation(lon: Double, lat: Double) {
        UserDefaults.standard.set(lon, forKey: "currentLongtitude")
        UserDefaults.standard.set(lat, forKey: "currentLatitude")
        print("UserDefaults에 현재 위치 저장 완료")
    }
    
}
