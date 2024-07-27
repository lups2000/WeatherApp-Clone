//
//  Location.swift
//  WeatherApp
//
//  Created by matteo luppi on 04/04/24.
//

import Foundation

@Observable public class Location: Codable {
    public var latitude: Double
    public var longitude: Double
    public var city: String
    public var country: String
    public var weatherForecast: Forecast?
    
    public init(latitude: Double,
                longitude: Double,
                city: String,
                country: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.city = city
        self.country = country
    }
    
    public func addWeatherForecast(_ weather: Forecast?) {
        guard let weather = weather else {
            return
        }
        self.weatherForecast = weather
    }
}

extension Location: Hashable {
    public func hash(into hasher: inout Hasher) {
            hasher.combine(latitude)
            hasher.combine(longitude)
            hasher.combine(city)
            hasher.combine(country)
    }
}

extension Location: Equatable {
    public static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.latitude == rhs.latitude &&
               lhs.longitude == rhs.longitude &&
               lhs.city == rhs.city &&
               lhs.country == rhs.country
    }
}
