//
//  ReadDateCityFromFileCSV.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct ReadDateCity {
    
    static let shared = ReadDateCity()
    
    private init() { }

    func loadLocationFromCSV() -> [CityWorld] {
        guard let cityPath = Bundle.main.path(forResource: "city", ofType: "csv") else {
            fatalError("Cannot load location.csv file")
        }
        
        var allCityWorld = [CityWorld]()
        let urls =  URL(fileURLWithPath: cityPath)
        do {
            let data = try Data(contentsOf: urls)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArray = dataEncoded?.components(separatedBy: "\n").map { $0.components(separatedBy: ",") } {
                for line in dataArray where line.count > 5 {
                    let cityWorld = createLocation(line: line)
                    allCityWorld.append(cityWorld)
                }
            }
        } catch {
            fatalError("Error reading CSV file")
        }
        return allCityWorld
    }
    
    private func createLocation(line: [String]) -> CityWorld {
        let cityWorld = CityWorld(city: line[0], lat: line[1], lon: line[2], country: line[3], countryCode: line[4], adminCity: line[5], isCurrentLocation: false)
        return cityWorld
    }
}
