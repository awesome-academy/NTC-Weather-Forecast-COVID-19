//
//  ViewControllerWeather.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    @IBOutlet private weak var cityLable: UILabel!
    @IBOutlet private weak var countryLable: UILabel!
    @IBOutlet private weak var timeLable: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var descriptionLable: UILabel!
    @IBOutlet private weak var tempLable: UILabel!
    @IBOutlet private weak var humidityLable: UILabel!
    @IBOutlet private weak var windSpeedLable: UILabel!
    @IBOutlet private weak var sevenWeatherTableView: UITableView!
    
    private var city = CityWorld(city: "Nam Định", lat: "20.4200", lon: "106.1683", country: "Vietnam", countryCode: "", adminCity: "", isCurrentLocation: false)
    private var sevenDaysWeather = SevenDaysWeather()
    private var currentWeather = CurrentWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadAPI()
    }
    
    func setup() {
        sevenWeatherTableView.dataSource = self
    }
    
    private func loadAPI() {
        let lat = Double(city.lat) ?? 0
        let long = Double(city.lon) ?? 0
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        WeatherAPIService.shared.getCurrentWeatherByLocate(lat: lat, long: long) { result in
            switch result {
            case .success(let currentWeather):
                self.currentWeather = currentWeather
                dispatchGroup.leave()
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.enter()
        WeatherAPIService.shared.get7DaysWeather(lat: lat, long: long) { result in
            switch result {
            case .success(let sevenDaysWeather):
                self.sevenDaysWeather = sevenDaysWeather
                dispatchGroup.leave()
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.loadData()
            self.sevenWeatherTableView.reloadData()
        }
    }
    
    func loadData() {
        self.cityLable.text = city.city
        self.countryLable.text = city.country
        if currentWeather.weather.isEmpty {
            let alter = UIAlertController(title: "Thong bao", message: "Not data weather of this City!", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .default) { (_) in
            }
            alter.addAction(actionOk)
            self.present(alter, animated: true, completion: nil)
        } else {
            let urlString = "http://openweathermap.org/img/wn/" + currentWeather.weather[0].icon + ".png"
            if let url = URL(string: urlString) {
                self.iconImageView.setImage(from: url)
            }
            self.descriptionLable.text = currentWeather.weather[0].description.uppercased()
            self.tempLable.text = String(Int(round(currentWeather.main.temp - 273))) + "°C"
            self.humidityLable.text = String(currentWeather.main.humidity) + "%"
            self.windSpeedLable.text = String(currentWeather.wind.speed) + " m/s"

            let dateFormatCoordinate = DateFormatter()
            dateFormatCoordinate.dateFormat = "EEEE yyyy-MM-dd HH:mm:ss"
            let time = currentWeather.time
            let timeInterval = TimeInterval(time)
            let date = NSDate( timeIntervalSince1970: timeInterval)
            self.timeLable.text = dateFormatCoordinate.string(from: date as Date)
        }
    }
    
    @IBAction func click_SettingButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "SettingTempSS", sender: nil)
    }
    
    @IBAction func click_GoToSearchCityScreenButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "SearchCitySS", sender: nil)
    }
    
    @IBAction func click_SeeDetailButton(_ sender: UIButton) {
        if let detailWeatherScreen = self.storyboard?.instantiateViewController(identifier: "DetailWeatherSB") as? DetailWeatherViewController {
            self.navigationController?.pushViewController(detailWeatherScreen, animated: true)
        } else {
            print("Error click See Detail")
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sevenDaysWeather.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SevenWeatherCell") as? SevenDaysWeatherTableViewCell {
            cell.initDataUI(data7DaysWeather: sevenDaysWeather.data[indexPath.row])
            return cell
        } else {
            print("DequeueReusableCell failed while casting")
        }
        return UITableViewCell()
    }
}
