//
//  WeatherNetworkingManager.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/06/14.
//

// 요청 URL : https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

import Foundation
import Alamofire

struct WeatherNetworkingManager {
    
    static let shared = WeatherNetworkingManager()
    
    private let url = "https://api.openweathermap.org/data/2.5/weather"
    
    private let key = "6696681dc36b931f936a34be8b02a7db"
    
    private init() { }
    
// MARK: - Parameters
    private func parameters(coordinate: Coordinate) -> [String: Any] {
        [
            "lat": coordinate.latitude,
            "lon": coordinate.longtitude,
            "lang": "kr", // 언어 - 한국어
            "appid": key
        ]
    }
    
// MARK: - GET Methods
    /// 좌표로 날씨 데이터 요청해서 받기
    func getWeatherData(coordinate: Coordinate, completion: @escaping (Weather) -> Void) {
        guard let url = URL(string: url) else {
            print("WeatherNetworkingManager - URL ERROR")
            return
        }
        AF.request(url,
                   method: .get,
                   parameters: parameters(coordinate: coordinate),
                   encoding: URLEncoding.default)
        .responseDecodable(of: Weather.self) { response in
            switch response.result {
            case .success(let weather):
                completion(weather)
            case .failure(let error):
                print("WeatherNetworkingManager - \(error)")
            }
        }
    }
    
}
