//
//  Model.swift
//  WeatherApp
//
//  Created by matteo luppi on 05/04/24.
//

import Foundation

@Observable public class Model {
    public var locations : [Location]
    public var user: User
    public var formatAsCelsius: Bool
    
    public init(locations: [Location] = [], user: User) {
        self.locations = locations
        self.user = user
        self.formatAsCelsius = true
    }
    
    public func save(_ location: Location) {
        if let index = locations.firstIndex(where: { $0.city == location.city && $0.country == location.country }) {
            locations.remove(at: index)
        }
        locations.insert(location, at: 0)
    }
    
    public func clearLocations() {
        self.locations = []
    }
    
    func convertTemperature(_ temperature: Double) -> Double {
        if formatAsCelsius {
            return temperature
        } else {
            return (temperature * 9 / 5) + 32
        }
    }
}
