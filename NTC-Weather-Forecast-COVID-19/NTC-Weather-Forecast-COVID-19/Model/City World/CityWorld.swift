//
//  CityWorld.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct CityWorld: Codable {
    var city: String
    var lat: String
    var lon: String
    var country: String
    var countryCode: String
    var adminCity: String
    var isCurrentLocation: Bool
}
