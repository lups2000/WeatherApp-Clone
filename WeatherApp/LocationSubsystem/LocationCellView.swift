//
//  LocationComponent.swift
//  WeatherApp
//
//  Created by matteo luppi on 04/04/24.
//

import SwiftUI
import os

struct LocationCellView: View {
    @State private var viewModel: LocationCellViewModel
    let location: Location
    let currentDate = Date()
    private let logger = Logger(subsystem: "com.WeatherApp", category: "locationCellView")
    
    
    var body: some View {
        NavigationLink(destination: WeatherView(location: location, model: viewModel.model)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(location.city).font(Font.custom("Roboto-Regular", size: 22))
                    Text(DateFormatter.onlyTime.string(from: currentDate))
                    Spacer()
                    if let description = viewModel.forecast?.current.weather[0].description {
                        Text(description)
                    } else if viewModel.isLoading {
                        ProgressView() // Display a progress view while loading
                    } else if viewModel.error != nil {
                        Text("Error").foregroundColor(.red) // Display an error message if an error occurs
                    }
                }
                Spacer()
                VStack(alignment: .trailing) {
                    if let forecast = viewModel.forecast {
                        Text("\(Int(viewModel.model.convertTemperature(forecast.current.temp)))°").font(.system(size: 45))
                        Spacer()
                        HStack {
                            Text("Max: \(Int(viewModel.model.convertTemperature(forecast.daily[0].temp.max)))°")
                            Text("Min: \(Int(viewModel.model.convertTemperature(forecast.daily[0].temp.min)))°")
                        }
                    } else if viewModel.isLoading {
                        ProgressView() // Display a progress view while loading
                    } else if viewModel.error != nil {
                        Text("Error").foregroundColor(.red) // Display an error message if an error occurs
                    }
                }
            }
            .padding()
            .background(viewModel.customBackGroundColor)
            .cornerRadius(20)
        }.buttonStyle(PlainButtonStyle())
         .task {
             viewModel.fetchWeather()
             logger.info("Weather data fetched for location: \(location.city)")
         }
    }
    
    init(_ model: Model, location: Location) {
        self._viewModel = State(wrappedValue: LocationCellViewModel(location: location, model: model))
        self.location = location
    }
}

#Preview {
    let model : Model = MockModel()
    return LocationCellView(model, location: Location(latitude: 40, longitude:-74.0, city: "New York", country: "USA"))
        .environment(model)
}
