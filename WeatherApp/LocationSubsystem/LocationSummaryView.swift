//
//  LocationsView.swift
//  WeatherApp
//
//  Created by matteo luppi on 05/04/24.
//

import SwiftUI
import os

struct LocationsSummaryView: View {
        @State private var viewModel: LocationsSummaryViewModel
        private let logger = Logger(subsystem: "com.WeatherApp", category: "locationsSummaryView")
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search for a city",
                              text: $viewModel.locality).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        logger.info("Added city: \(viewModel.locality)")
                        viewModel.addLocality()
                    } label: {
                        Image(systemName: "magnifyingglass").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                }.padding(.bottom, 10)
                ScrollView(.vertical, showsIndicators: false) {
                    LocationListView()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Locations")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    menuOptions
                }
            }
        }
    }
    
    private var menuOptions: some View {
            Menu {
                Section {
                    Toggle("Celsius", isOn: $viewModel.isCelsius)
                        .onChange(of: viewModel.isCelsius) {
                            viewModel.isFahrenheit = !$1
                        }
                    Toggle("Fahrenheit", isOn: $viewModel.isFahrenheit)
                        .onChange(of: viewModel.isFahrenheit) {
                            viewModel.isCelsius = !$1
                        }
                }
                Section {
                    Button(role: .destructive) {
                        viewModel.clearLocations()
                    } label: {
                        Text("Delete locations")
                        Image(systemName: "trash")
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            .menuActionDismissBehavior(.disabled)
        }
        
    
    init(_ model: Model) {
        self._viewModel = State(wrappedValue: LocationsSummaryViewModel( model: model))
    }
}

#Preview {
    let model : Model = MockModel()
    return LocationsSummaryView(model)
        .environment(model)
}
