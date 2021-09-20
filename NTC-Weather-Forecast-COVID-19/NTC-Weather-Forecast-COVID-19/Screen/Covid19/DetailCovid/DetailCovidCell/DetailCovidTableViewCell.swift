//
//  DetailCountryCovidTableViewCell.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/16/21.
//

import UIKit

final class DetailCovidTableViewCell: UITableViewCell, ReusableView {

    @IBOutlet private weak var detailCountryCovidView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var confirmedLabel: UILabel!
    @IBOutlet private weak var deathsLabel: UILabel!
    @IBOutlet private weak var recoveredLabel: UILabel!
    @IBOutlet private weak var activeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailCountryCovidView.layer.cornerRadius = detailCountryCovidView.frame.height / 10
    }
    
    func configView(countryCovid: CountryCovid) {
        timeLabel.text = countryCovid.date.subStringTime()
        confirmedLabel.text = countryCovid.confirmed.toString()
        deathsLabel.text = countryCovid.deaths.toString()
        recoveredLabel.text = countryCovid.recovered.toString()
        activeLabel.text = countryCovid.active.toString()
    }
}
