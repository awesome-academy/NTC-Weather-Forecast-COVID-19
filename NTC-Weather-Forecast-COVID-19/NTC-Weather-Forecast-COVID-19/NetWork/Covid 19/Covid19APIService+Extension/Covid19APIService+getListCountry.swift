//
//  Covid19APIService+getDetailWeather.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/31/21.
//

import Foundation

extension Covid19APIService {
    func getListCountry(completion: @escaping (Result<[Country], Error>) -> Void) {
        Covid19APIService.shared.pullJSONData(url: URL(string: Covid19Network.shared.getListCountry())) { (result) in
            switch result {
            case .success(let JSONData):
                let countryData = try? JSONDecoder().decode([Country].self, from: JSONData)
                if let countryData = countryData {
                    completion(.success(countryData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
