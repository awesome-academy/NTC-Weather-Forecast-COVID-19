//
//  DetailWeatherTableViewCell.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/9/21.
//

import UIKit

protocol DetailWeatherDelegate: AnyObject {
    func sendCheckMark(isMark: Bool, index: Int)
}

final class DetailWeatherTableViewCell: UITableViewCell, ReusableView {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var detailWeatherView: UIView!
    @IBOutlet private weak var markButton: UIButton!
    private var isMark = false
    private var index = 0
    weak var delegate: DetailWeatherDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        detailWeatherView.layer.cornerRadius = detailWeatherView.frame.height / 5
    }
    
    func configView(weather: DataDetailWeather,
                    indexTemp: Int,
                    isMark: Bool,
                    index: Int) {
        self.isMark = isMark
        self.index = index
        let urlString = WeatherNetwork.shared.getIcon(icon: weather.weather.first?.icon ?? "",
                                                      typeCurrentTime: true)
        if let url = URL(string: urlString) {
            iconImageView.setImage(from: url)
        }
        let dateFormatCoordinate = DateFormatter()
        timeLabel.text = dateFormatCoordinate.dateFormatWeather(time: weather.time,
                                                                typeCurrentTime: true)
        descriptionLabel.text = weather.weather.first?.description
        humidityLabel.text =  "\(weather.main.humidity)%"
        tempLabel.formatTemperature(temp: weather.main.temp - 273,
                                    indexTemp: indexTemp)
        windSpeedLabel.text = "\(weather.wind.speed) m/s"
        
        let image = UIImage(systemName: isMark ? "heart.fill" :  "heart")
        markButton.setImage(image, for: .normal)
    }
    
    @IBAction
    private func clickMarkButton(_ sender: UIButton) {
        isMark = !isMark
        let image = UIImage(systemName: isMark ? "heart.fill" : "heart")
        markButton.setImage(image, for: .normal)
        delegate?.sendCheckMark(isMark: isMark, index: index)
    }
}
