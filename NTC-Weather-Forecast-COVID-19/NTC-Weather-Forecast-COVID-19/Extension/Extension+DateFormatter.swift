//
//  Extension+Date.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/2/21.
//

import Foundation

extension DateFormatter {
    func dateFormatWeather(time: CLong, typeCurrentTime: Bool) -> String {
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = typeCurrentTime ? "EEEE yyyy-MM-dd HH:mm:ss" : "EEEE"
        let timeInterval = TimeInterval(time)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        return dateFormatCoordinate.string(from: date as Date)
    }
    
    func convertStringToDate(string: String) -> Date {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let date = dateFormat.date(from: string) ?? Date()
        return date
    }
    
    func covertDateToString(date: Date) -> String {
        let datefomat = DateFormatter()
        datefomat.dateFormat = "yyyy-MM-dd"
        let string = datefomat.string(from: date)
        return string
    }
}
