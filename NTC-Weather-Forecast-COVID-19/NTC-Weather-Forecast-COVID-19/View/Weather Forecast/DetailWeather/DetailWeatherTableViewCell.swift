//
//  DetailWeatherTableViewCell.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/9/21.
//

import UIKit

final class DetailWeatherTableViewCell: UITableViewCell, ReusableView {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var detailWeatherView: UIView!
    @IBOutlet private weak var markButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        detailWeatherView.layer.cornerRadius = detailWeatherView.frame.height / 5
    }
    
    func configView(dataDetailWeather: DataDetailWeather, indexTemp: Int) {
        let urlString = WeatherNetwork.shared.getIcon(icon: dataDetailWeather.weather.first?.icon ?? "",
                                                      typeCurrentTime: true)
        if let url = URL(string: urlString) {
            iconImageView.setImage(from: url)
        }
        let dateFormatCoordinate = DateFormatter()
        timeLabel.text = dateFormatCoordinate.dateFormatWeather(time: dataDetailWeather.time,
                                                                typeCurrentTime: true)
        descriptionLabel.text = dataDetailWeather.weather.first?.description
        humidityLabel.text =  "\(dataDetailWeather.main.humidity)%"
        tempLabel.formatTemperature(temp: dataDetailWeather.main.temp - 273,
                                    indexTemp: indexTemp)
        windSpeedLabel.text = "\(dataDetailWeather.wind.speed) m/s"
        
    }
    
}
