//
//  Covid19APIService+get.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/31/21.
//

import Foundation

extension Covid19APIService {
    func getCountryCovid(slug: String, completion: @escaping (Result<[CountryCovid], Error>) -> Void) {
        Covid19APIService.shared.pullJSONData(url: URL(string: Covid19Network.shared.getCovidCountry(slug: slug))) { (result) in
            switch result {
            case .success(let JSONData):
                let covidCountryData = try? JSONDecoder().decode([CountryCovid].self, from: JSONData)
                if let countryCovidData = covidCountryData {
                    completion(.success(countryCovidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
