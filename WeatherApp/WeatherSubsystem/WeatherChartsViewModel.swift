//
//  WeatherChartsViewModel.swift
//  WeatherApp
//
//  Created by matteo luppi on 07/04/24.
//

import Foundation
import SwiftUI


@Observable class WeatherChartsViewModel {
    var location: Location
    let model: Model
    
    init(location: Location, model: Model) {
        self.location = location
        self.model = model
    }
    
    func extractDailyTemperatures() -> [(String, Double)] {
        var result: [(String, Double)] = []
        let forecast = location.weatherForecast
        if let daily = forecast?.daily {
            for day in daily {
                let dayWeek = DateFormatter.onlyDay.string(from: day.dt)
                result.append((dayWeek, model.convertTemperature((day.temp.day))))
            }
        }
        return result
    }
    
    func extractDailyHumidities() -> [(String, Int)] {
        var result: [(String, Int)] = []
        let forecast = location.weatherForecast
        if let daily = forecast?.daily {
            for day in daily {
                let dayWeek = DateFormatter.onlyDay.string(from: day.dt)
                result.append((dayWeek, day.humidity))
            }
        }
        return result
    }
}
