//
//  WeatherForecastsView.swift
//  WeatherApp
//
//  Created by matteo luppi on 07/04/24.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct WeatherForecastsView: View {
    let location: Location
    let model: Model
    
    var body: some View {
        if let dailyForecasts = location.weatherForecast?.daily {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(dailyForecasts, id: \.dt) { day in
                    HStack {
                        Text("\(DateFormatter.onlyDay.string(from: day.dt))").bold()
                        WebImage(url: day.weather.first?.weatherIconURL) {image in image.resizable()
                        } placeholder: {
                            Image(systemName: "hourglass")
                        }.scaledToFit().frame(width: 55)
                        Spacer()
                        Text("\(Int(model.convertTemperature(day.temp.min)))° <---> \(Int(model.convertTemperature(day.temp.max)))°").bold()
                    }
                    Divider()
                }
            }
            .padding()
            .background(.quaternary)
            .cornerRadius(10)
        } else {
            Text("No daily forecasts available")
                .padding()
                .background(.tertiary)
                .cornerRadius(10)
        }
    }
}

#Preview {
    let model: Model = MockModel()
    return WeatherForecastsView(
        location: Location(
            latitude: 40.7128,
            longitude: -74.0060,
            city: "New York",
            country: "USA"
        ),
        model: model
    )
}
