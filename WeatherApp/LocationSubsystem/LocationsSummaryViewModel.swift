//
//  LocationsSummaryViewModel.swift
//  WeatherApp
//
//  Created by matteo luppi on 06/04/24.
//

import Foundation
import SwiftUI
import CoreLocation

@Observable class LocationsSummaryViewModel {
    var locality: String = ""
    var isSearching = false
    var isModalShowing = false
    
    var isCelsius: Bool {
        didSet {
            if isCelsius {
                model.formatAsCelsius = true
                isFahrenheit = false
            }
        }
    }
    
    var isFahrenheit: Bool {
        didSet {
            if isFahrenheit {
                model.formatAsCelsius = false
                isCelsius = false
            }
        }
    }
    
    private let model: Model
    
    init(model: Model) {
        self.model = model
        self.isCelsius = model.formatAsCelsius
        self.isFahrenheit = !model.formatAsCelsius
    }
    
    func clearLocations() {
        model.clearLocations()
    }
    
    func addLocality() {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(locality) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let placemark = placemarks?.first {
                let location = Location(
                    latitude: placemark.location?.coordinate.latitude ?? 0.0,
                    longitude: placemark.location?.coordinate.longitude ?? 0.0,
                    city: placemark.locality ?? "",
                    country: placemark.country ?? ""
                )
                
                self.model.save(location)
                self.locality = ""
            }
        }
    }
}
