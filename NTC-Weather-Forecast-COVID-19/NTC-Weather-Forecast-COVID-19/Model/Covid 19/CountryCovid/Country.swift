//
//  Country.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct Country: Codable {
    let name: String
    let slug: String
    let ios: String
    
    init() {
        name = ""
        slug = ""
        ios = ""
    }

    init(name: String, slug: String, ios: String) {
        self.name = name
        self.slug = ios
        self.ios = ios
    }

    enum CodingKeys: String, CodingKey {
        case name = "Country"
        case slug = "Slug"
        case ios  = "ISO2"
    }
}
