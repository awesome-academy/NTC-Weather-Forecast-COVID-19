//
//  DetailWeatherViewController.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/1/21.
//

import UIKit
import CoreData

final class DetailWeatherViewController: UIViewController {

    @IBOutlet private weak var detailWeatherNavigationItem: UINavigationItem!
    @IBOutlet private weak var detailWeatherTableView: UITableView!
    private var detailWeather = DetailWeather()
    private let keyTempFormat = UserDefaultsKeys.keyTempFomat.rawValue
    private var indexTemp = 0
    var cityWorld = CityWorld()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailWeatherTableView.dataSource = self
        detailWeatherTableView.delegate = self
        detailWeatherTableView.register(DetailWeatherTableViewCell.nib,
                                        forCellReuseIdentifier: DetailWeatherTableViewCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        indexTemp = (UserDefaults.standard.value(forKey: keyTempFormat) as? Int) ?? 0
        detailWeatherNavigationItem.title = cityWorld.city
        loadAPI()
    }
    
    private func loadAPI() {
        let lat = Double(cityWorld.lat) ?? 0
        let long = Double(cityWorld.long) ?? 0
        
        WeatherAPIService.shared.getDetailWeather(lat: lat, long: long) { result in
            switch result {
            case .success(let detailWeather):
                self.detailWeather = detailWeather
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.detailWeatherTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DetailWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailWeather.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: DetailWeatherTableViewCell.reuseIdentifier)
            as? DetailWeatherTableViewCell {
            cell.delegate = self
            let weather = detailWeather.list[indexPath.row].convertToWeatherEntity(city: cityWorld.city)
            let isMark = WeatherManager.shared.isWeatherEntity(weather: weather)
            cell.configView(weather: detailWeather.list[indexPath.row],
                            indexTemp: indexTemp,
                            isMark: isMark,
                            index: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.5, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1)
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
                })
        })
    }
}

extension DetailWeatherViewController: DetailWeatherDelegate {
    func sendCheckMark(isMark: Bool, index: Int) {
        let weather = detailWeather.list[index].convertToWeatherEntity(city: cityWorld.city)
        isMark ?
            WeatherManager.shared.createWeatherEntity(weather: weather) :
            WeatherManager.shared.deleteWeatherEntity(weather: weather)
    }
}
