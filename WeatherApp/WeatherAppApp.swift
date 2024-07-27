//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by matteo luppi on 04/04/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @State var globalViewModel: Model = MockModel()
    var body: some Scene {
        WindowGroup {
            LocationsSummaryView(globalViewModel)
        }
        .environment(globalViewModel)
    }
}
