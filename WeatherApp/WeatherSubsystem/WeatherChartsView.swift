//
//  WeatherGraphs.swift
//  WeatherApp
//
//  Created by matteo luppi on 06/04/24.
//

import SwiftUI
import SwiftUICharts

struct WeatherChartsView: View {
    @State private var viewModel: WeatherChartsViewModel
    
    var body: some View {
        let temperatures = viewModel.extractDailyTemperatures()
        let humidities = viewModel.extractDailyHumidities()
        VStack {
            Text("Charts").bold().font(.system(size: 30))
            BarChartView(
                data: ChartData(
                    values: temperatures
                ),
                title: "Temperature",
                legend: "Weekly",
                form: ChartForm.extraLarge,
                valueSpecifier: "%.1f °"
            ).padding(.bottom, 30)
            BarChartView(
                data: ChartData(
                    values: humidities
                ),
                title: "Humidity",
                legend: "Weekly",
                style: Styles.barChartMidnightGreenLight,
                form: ChartForm.extraLarge,
                valueSpecifier: "%.1f%%"
            )
            Spacer()
        }
        .padding()
    }
    
    init(location: Location, model: Model) {
        self._viewModel = State(wrappedValue: WeatherChartsViewModel(location: location, model: model))
    }
}

#Preview {
    let model: Model = MockModel()
    return WeatherChartsView(
        location: Location(
            latitude: 40,
            longitude:-74.0,
            city: "New York",
            country: "USA"
        ),
        model: model
    )
}
