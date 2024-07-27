//
//  MockModel.swift
//  WeatherApp
//
//  Created by matteo luppi on 05/04/24.
//

import Foundation

public class MockModel: Model {
    public convenience init() {
        let locations: [Location] = [
            Location(latitude: 48.1351, longitude: 11.5820, city: "Munich", country: "Germany"),
        ]
        self.init(locations: locations, user: User(apiKey: "e83761ef079cd8a1cdd22242a7048542"))
    }
}
