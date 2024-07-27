//
//  LocationCellModelView.swift
//  WeatherApp
//
//  Created by matteo luppi on 06/04/24.
//

import Foundation
import SwiftUI
import os


@Observable class LocationCellViewModel {
    var forecast: Forecast?
    var isLoading = false
    var error: Error?
    
    private let location: Location
    let model: Model
    
    private let logger = Logger(subsystem: "com.WeatherApp", category: "locationCellViewModel")
        
    init(location: Location, model: Model) {
        self.location = location
        self.model = model
    }
    
    var customBackGroundColor: Color {
        if let currentWeatherDesc = forecast?.current.weather.first?.description {
            switch currentWeatherDesc {
            case "clear sky":
                return Color.blue.opacity(0.3)
            case "few clouds", "scattered clouds", "broken clouds", "overcast clouds":
                return Color.gray.opacity(0.3)
            case "shower rain", "rain":
                return Color.blue.opacity(0.7) // Light blue for rain
            case "thunderstorm":
                return Color.purple.opacity(0.7) // Purple for thunderstorm
            case "snow":
                return Color.white
            case "mist", "fog", "haze":
                return Color.gray.opacity(0.5) // Gray with opacity for mist, fog, haze
            default:
                return Color.gray
            }
        }
        // Return a default color if the weather description is not matched
        return Color.gray
    }

    func fetchWeather() {
            isLoading = true

            let apiKey = model.user.apiKey
            let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)&units=metric&exclude=minutely,hourly,alerts"

            guard let url = URL(string: urlString) else {
                isLoading = false
                return
            }

            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self else {
                    return
                }

                if let error = error {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.error = error
                        self.logger.error("Error fetching weather data: \(error)")
                    }
                    return
                }

                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let decodedResponse = try decoder.decode(Forecast.self, from: data)
                        DispatchQueue.main.async {
                            self.forecast = decodedResponse // store the forecast
                            self.location.addWeatherForecast(self.forecast) // add it to the location
                            self.isLoading = false
                            self.logger.info("Weather data fetched for location: \(self.location.city)")
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.error = error
                            self.logger.error("Error decoding weather data: \(error)")
                        }
                    }
                }
            }

            task.resume()
        }
}
