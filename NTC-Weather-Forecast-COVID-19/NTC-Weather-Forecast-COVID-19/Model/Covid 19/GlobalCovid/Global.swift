//
//  Global.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct Global: Codable {
    let totalConfirmed: Int
    let totalDeaths: Int
    let totalRecovered: Int
    
    init() {
        totalConfirmed = 0
        totalDeaths = 0
        totalRecovered = 0
    }
    
    init(totalConfirmed: Int, totalDeaths: Int, totalRecovered: Int) {
        self.totalConfirmed = totalConfirmed
        self.totalDeaths = totalDeaths
        self.totalRecovered = totalRecovered
    }
    
    enum CodingKeys: String, CodingKey {
        case totalConfirmed = "TotalConfirmed"
        case totalDeaths = "TotalDeaths"
        case totalRecovered  = "TotalRecovered"
    }
}
