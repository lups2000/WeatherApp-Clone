//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by matteo luppi on 05/04/24.
//

import Foundation

extension DateFormatter {
    public static let onlyTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    public static let onlyDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    public static let onlyDay: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE" // "EEE" represents the abbreviated day name
        return dateFormatter
    }()
}
