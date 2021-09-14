//
//  DataDetailWeatherRepository.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/9/21.
//

import Foundation
import CoreData
import UIKit

protocol WeatherRepositoryType {
    func createWeatherEntity(weather: WeatherEntity)
    func getAllWeatherEntity() -> [WeatherEntity]
    func isWeatherEntity(weather: WeatherEntity) -> Bool
    func deleteWeatherEntity(weather: WeatherEntity)
}

struct WeatherRepository: WeatherRepositoryType {
    func createWeatherEntity(weather: WeatherEntity) {
        if isWeatherEntity(weather: weather) {
            return
        }
        let weatherCD = DataDetailWeatherCD(context: PersistentStorage.shared.context)
        weatherCD.id = weather.id
        weatherCD.city = weather.city
        weatherCD.humidity = weather.humidity
        weatherCD.icon = weather.icon
        weatherCD.des = weather.des
        weatherCD.speedWind = weather.speedWind
        weatherCD.temp = weather.temp
        weatherCD.time = weather.time
        PersistentStorage.shared.saveContext()
    }
    
    func getAllWeatherEntity() -> [WeatherEntity] {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: DataDetailWeatherCD.self)
        
        var weathers = [WeatherEntity]()
        
        weathers = result?.compactMap({
            $0.convertToWeatherEntity()
        }) ?? [WeatherEntity]()
        
        let weathersNotExpired = weathers.filter { checkExpired(weather: $0) == true }
        return weathersNotExpired
    }
    
    func isWeatherEntity(weather: WeatherEntity) -> Bool {
        let fetchRequest = NSFetchRequest<DataDetailWeatherCD>(entityName: "DataDetailWeatherCD")
        let predicate = NSPredicate(format: "id == %@", weather.id)

        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            guard result != nil else { return false }
            
            return true
        } catch {
            return false
        }
        
    }
    
    func deleteWeatherEntity(weather: WeatherEntity) {
        if !isWeatherEntity(weather: weather) {
            return
        }
        let request = NSFetchRequest<DataDetailWeatherCD>(entityName: "DataDetailWeatherCD")
        request.predicate = NSPredicate(format: "id == %@", weather.id)
        let dataDetailWeatherCDs = try? PersistentStorage.shared.context.fetch(request)

        if let dataDetailWeatherCDs = dataDetailWeatherCDs {
            for dataDetailWeatherCD in dataDetailWeatherCDs {
                PersistentStorage.shared.context.delete(dataDetailWeatherCD)
            }
        }
        PersistentStorage.shared.saveContext()
    }
    
    func checkExpired(weather: WeatherEntity) -> Bool {
        let currentTime = Int(Date().timeIntervalSince1970)
        return Int(weather.time) >= currentTime
    }
}
