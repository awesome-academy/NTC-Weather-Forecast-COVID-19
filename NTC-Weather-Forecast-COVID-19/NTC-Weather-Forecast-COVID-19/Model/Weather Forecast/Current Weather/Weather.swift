//
//  Weather.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct Weather: Codable {
    let description: String
    let icon: String
    
    init() {
        description = ""
        icon = ""
    }
    
    init(description: String, icon: String) {
        self.description = description
        self.icon = icon
    }
}
