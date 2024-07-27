//
//  NumbersFormatterWeatherApp.swift
//  WeatherApp
//
//  Created by matteo luppi on 07/04/24.
//

import Foundation

extension NumberFormatter {
    public static let formatNumber: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }()
}
