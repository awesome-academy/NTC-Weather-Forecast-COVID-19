//
//  APIKey.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct ReadAPIKey {
    
    static let shared = ReadAPIKey()
    
    private init() { }

    func loadAPIKeysFromCSV() -> APIKey {
        guard let cityPath = Bundle.main.path(forResource: "Key", ofType: "csv") else {
            fatalError("Cannot load Key.csv file")
        }
        
        var apiKey = APIKey(keyOpenWeatherMap: "", keyWeatherBit: "")
        let urls =  URL(fileURLWithPath: cityPath)
        do {
            let data = try Data(contentsOf: urls)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArray = dataEncoded?.components(separatedBy: "\n").map { $0.components(separatedBy: ",") } {
                let line = dataArray[0]
                apiKey.keyOpenWeatherMap = line[0]
                apiKey.keyWeatherBit = line[1]
            }
        } catch {
            fatalError("Error reading CSV file")
        }
        return apiKey
    }
}
