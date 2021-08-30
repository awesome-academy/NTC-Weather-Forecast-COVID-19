//
//  Covid19Network.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct Covid19Network {

    static let shared = Covid19Network()
    
    private init() { }
    
    private let baseUrl = "https://api.covid19api.com"
    
    func getListCountry() -> String {
        return "\(baseUrl)/countries"
    }
    
    func getCovidGlobal() -> String {
        return "\(baseUrl)/summary"
    }
    
    func getCovidCountry(slug: String) -> String {
        return "\(baseUrl)/dayone/country/\(slug)"
    }
}
