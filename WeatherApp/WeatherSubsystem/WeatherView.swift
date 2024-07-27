//
//  WeatherView.swift
//  WeatherApp
//
//  Created by matteo luppi on 04/04/24.
//

import SwiftUI

struct WeatherView: View {
    let location: Location
    let model: Model
    
    @State private var isSheetPresented = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            WeatherDetailsView(location: location, model: model)
            WeatherForecastsView(location: location, model: model)
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Image(systemName: "chart.xyaxis.line")
                        .font(.system(size: 25))
                    
                    Text("Charts")
                        .bold()
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        isSheetPresented.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.blue)
                            .font(.system(size: 25))
                    }
                }
                Text("Click here to view weekly temperature and humidity charts")
                    .font(.subheadline) // Adjust font size if needed
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .sheet(isPresented: $isSheetPresented) {
                WeatherChartsView(location: location, model: model)
            }
        }.padding(.horizontal, 15)
    }
}

#Preview {
    let model: Model = MockModel()
    return WeatherView(
        location: Location(
            latitude: 40.7128,
            longitude: -74.0060,
            city: "New York",
            country: "USA"
        ),
        model: model
    )
}
