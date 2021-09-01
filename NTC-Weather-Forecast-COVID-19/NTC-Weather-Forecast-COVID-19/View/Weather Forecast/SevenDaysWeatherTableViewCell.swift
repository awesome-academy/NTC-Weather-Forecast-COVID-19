//
//  SevenWeatherTableViewCell.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/1/21.
//

import UIKit

final class SevenDaysWeatherTableViewCell: UITableViewCell {

    @IBOutlet private weak var sevenDaysWeatherView: UIView!
    @IBOutlet private weak var timeLable: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var tempLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initDataUI(data7DaysWeather:  Data7DaysWeather) {
        sevenDaysWeatherView.layer.cornerRadius = sevenDaysWeatherView.frame.height/3
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = "EEEE"
        let time = data7DaysWeather.time
        let timeInterval = TimeInterval(time)
        let date = NSDate( timeIntervalSince1970: timeInterval)
        timeLable.text = dateFormatCoordinate.string(from: date as Date)
        iconImageView.image = UIImage(named: data7DaysWeather.weather.icon)
        tempLable.text = String(Int(round(data7DaysWeather.temp))) + "°C"
    }

}
