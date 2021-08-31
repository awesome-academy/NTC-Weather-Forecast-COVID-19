//
//  GlobalCovid.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct GlobalCovid: Codable {
    let global: Global
    
    init() {
        global = Global()
    }
    
    init(global: Global) {
        self.global = global
    }
    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
    }
}
