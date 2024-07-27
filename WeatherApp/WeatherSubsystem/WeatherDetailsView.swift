//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by matteo luppi on 06/04/24.
//

import SwiftUI

struct WeatherDetailsView: View {
    let location: Location
    let model: Model
    
    var body: some View {
        let forecast = location.weatherForecast
        
        let maxTemp = forecast?.daily.first?.temp.max ?? 0
        let minTemp = forecast?.daily.first?.temp.min ?? 0
        
        VStack {
            Text(location.city)
                .font(.system(size: 25))
                .bold()
            
            if let currentWeather = forecast?.current {
                HStack {
                    Text("\(Int(model.convertTemperature(currentWeather.temp)))°")
                        .font(.system(size: 80))
                }
                
                Text(currentWeather.weather.first?.description ?? "")
                    .font(.system(size: 22))
                
                HStack {
                    Text("MAX: \(Int(model.convertTemperature(maxTemp)))°")
                    Text("MIN: \(Int(model.convertTemperature(minTemp)))°")
                }
            }
            
            Spacer()
        }
        .padding()
    }
}
