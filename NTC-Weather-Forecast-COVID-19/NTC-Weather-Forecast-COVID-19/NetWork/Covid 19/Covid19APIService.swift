//
//  Covid19APIService.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

class Covid19APIService {
    private init() {}
    
    static let shared = Covid19APIService()
    
    func pullJSONData(url: URL?, completion: @escaping (Result<Data, ErrorNetWork>) -> Void) {
        guard let url = url else {
            completion(.failure(.badURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error : HTTP Response Code Error")
                return
            }
            
            guard let data = data else {
                print("Error : No Response")
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
