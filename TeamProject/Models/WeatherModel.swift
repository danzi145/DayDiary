//
//  WeatherModel.swift
//  TeamProject
//
//  Created by Sam Sung on 2023/06/14.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let weather: [WeatherElement]?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}


// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}
