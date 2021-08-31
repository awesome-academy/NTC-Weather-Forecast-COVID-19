//
//  CovidCountry.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct CountryCovid: Codable {
    let country: String
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let active: Int
    let date: String
    
    init() {
        country = ""
        confirmed = 0
        deaths = 0
        recovered = 0
        active = 0
        date = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}
