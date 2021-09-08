//
//  SettingTempViewController.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/1/21.
//

import UIKit

final class SettingTempViewController: UIViewController {
    @IBOutlet private weak var settingTempTableView: UITableView!

    private var currentIndexTempFormat = 0
    private let keyTempFormat = UserDefaultsKeys.keyTempFomat.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTempTableView.delegate = self
        settingTempTableView.dataSource = self
        settingTempTableView.register(SettingTempTableViewCell.nib,
                                   forCellReuseIdentifier: SettingTempTableViewCell.reuseIdentifier)
        currentIndexTempFormat = (UserDefaults.standard.value(forKey: keyTempFormat) as? Int) ?? 0
    }
    
    private func updateTempFormatInUserDefaults(newValue: Int) {
        UserDefaults.standard.set(newValue, forKey: keyTempFormat)
    }
}

extension SettingTempViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TempFormat.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingTempTableViewCell.reuseIdentifier)
            as? SettingTempTableViewCell {
            let temp = TempFormat.allCases[indexPath.row].rawValue.components(separatedBy: " ")
            cell.configView(temp: temp)
            if indexPath.row == currentIndexTempFormat {
                cell.accessoryType = .checkmark
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if indexPath.row != currentIndexTempFormat {
            dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.updateTempFormatInUserDefaults(newValue: indexPath.row)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
