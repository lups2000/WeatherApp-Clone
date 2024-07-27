//
//  LocationListView.swift
//  WeatherApp
//
//  Created by matteo luppi on 05/04/24.
//

import SwiftUI

struct LocationListView: View {
    @Environment(Model.self) private var model: Model

    var body: some View {
        VStack(spacing: 20) {
            if model.locations.isEmpty {
                Text("There are no locations yet.")
            } else {
                ForEach(model.locations, id: \.self) { location in
                    LocationCellView(self.model, location: location)
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LocationListView()
}
