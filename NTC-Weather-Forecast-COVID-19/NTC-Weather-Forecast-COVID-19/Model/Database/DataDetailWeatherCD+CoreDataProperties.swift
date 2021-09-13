//
//  DataDetailWeatherCD+CoreDataProperties.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/9/21.
//
//

import Foundation
import CoreData

extension DataDetailWeatherCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataDetailWeatherCD> {
        return NSFetchRequest<DataDetailWeatherCD>(entityName: "DataDetailWeatherCD")
    }

    @NSManaged public var city: String?
    @NSManaged public var des: String?
    @NSManaged public var humidity: Double
    @NSManaged public var icon: String?
    @NSManaged public var speedWind: Double
    @NSManaged public var temp: Double
    @NSManaged public var time: Double
    @NSManaged public var id: String?
}

extension DataDetailWeatherCD: Identifiable {
    func convertToWeatherEntity() -> WeatherEntity {
            guard let id = self.id,
                  let city = self.city,
                  let icon = self.icon,
                  let des = self.des
            else {
                return WeatherEntity()
            }
            return WeatherEntity(id: id,
                               city: city,
                               humidity: self.humidity,
                               icon: icon,
                               des: des,
                               speedWind: self.speedWind,
                               temp: self.temp,
                               time: self.time)
        }
}
