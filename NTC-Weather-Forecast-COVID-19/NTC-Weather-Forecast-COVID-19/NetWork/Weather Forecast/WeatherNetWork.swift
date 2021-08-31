//
//  WeatherNetWork.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct WeatherNetwork {

    static let shared = WeatherNetwork()
    
    let APIkey = ReadAPIKey.shared.loadAPIKeysFromCSV()
    
    private init() { }
    
    private let baseUrl = "http://api.openweathermap.org/data/2.5"
    
    func getCurrentWeather(lat: Double, long: Double) -> String {
        return "\(baseUrl)/weather?lat=\(lat)&lon=\(long)&appid=\(APIkey.keyOpenWeatherMap)"
    }
    
    func get7DaysWeather(lat: Double, long: Double) -> String {
        return "https://api.weatherbit.io/v2.0/forecast/daily?lat=\(lat)&lon=\(long)&key=\(APIkey.keyWeatherBit)&days=7"
    }
    
    func getDetailWeather(lat: Double, long: Double) -> String {
        return "\(baseUrl)/forecast?lat=\(lat)&lon=\(long)&appid=\(APIkey.keyOpenWeatherMap)"
    }
    
}
