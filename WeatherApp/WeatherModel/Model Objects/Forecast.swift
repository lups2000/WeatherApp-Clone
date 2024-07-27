//
//  Weather.swift
//  WeatherApp
//
//  Created by matteo luppi on 04/04/24.
//

import Foundation

public struct Forecast: Codable {
    let current: Current
    let daily: [Daily]
}

struct Current: Codable {
    let dt: Date
    let temp: Double
    let weather: [Weather]
}

struct Daily: Codable {
    let dt: Date
    let temp: Temp
    let humidity: Int
    let weather: [Weather]
}

struct Weather : Codable {
    let id: Int
    let description: String
    let icon: String
    var weatherIconURL: URL? {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: urlString)
    }
}

struct Temp: Codable {
    let min: Double
    let max: Double
    let day: Double
}
