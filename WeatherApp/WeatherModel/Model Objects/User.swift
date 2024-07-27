//
//  User.swift
//  WeatherApp
//
//  Created by matteo luppi on 04/04/24.
//

import Foundation

public struct User {
  public enum TemperatureUnit: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
  }
  
  public var apiKey: String
  public var temperatureUnit: TemperatureUnit
  
  public init(apiKey: String) {
    self.apiKey = apiKey
      self.temperatureUnit = TemperatureUnit.celsius
  }
}

extension User: Hashable { }
