//
//  Covid19APIService+get.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/31/21.
//

import Foundation

extension Covid19APIService{
    func getGlobalCovid(completion: @escaping (Result<GlobalCovid, Error>) -> Void) {
        Covid19APIService.shared.pullJSONData(url: URL(string: Covid19Network.shared.getCovidGlobal())) { (result) in
            switch result {
            case .success(let JSONData):
                let globalCovidData = try? JSONDecoder().decode(GlobalCovid.self, from: JSONData)
                if let globalCovidData = globalCovidData {
                    completion(.success(globalCovidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
