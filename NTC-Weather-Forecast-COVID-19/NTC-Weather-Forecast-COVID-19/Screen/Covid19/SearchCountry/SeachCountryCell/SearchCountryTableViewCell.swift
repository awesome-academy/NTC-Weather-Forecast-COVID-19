//
//  SearchCountryTableViewCell.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/15/21.
//

import UIKit

final class SearchCountryTableViewCell: UITableViewCell, ReusableView {

    @IBOutlet private weak var nameCountryLabel: UILabel!
    @IBOutlet private weak var slugCountryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configView(country: Country) {
        nameCountryLabel.text = country.name
        slugCountryLabel.text = country.slug
    }
}
