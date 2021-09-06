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
    var long: String
    var country: String
    var countryCode: String
    var adminCity: String
    var isCurrentLocation: Bool
    
    init() {
        city = ""
        lat = ""
        long = ""
        country = ""
        countryCode = ""
        adminCity = ""
        isCurrentLocation = false
    }
    
    init(city: String,
         lat: String,
         long: String,
         country: String,
         countryCode: String,
         adminCity: String,
         isCurrentLocation: Bool) {
        self.city = city
        self.lat = lat
        self.long = long
        self.country = country
        self.countryCode = countryCode
        self.adminCity = adminCity
        self.isCurrentLocation = isCurrentLocation
    }
}
