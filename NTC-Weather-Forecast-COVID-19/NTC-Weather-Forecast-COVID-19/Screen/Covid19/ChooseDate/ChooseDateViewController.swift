//
//  ChooseDateViewController.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/16/21.
//

import UIKit

protocol ChooseDateDelegate: AnyObject {
    func sendDate(date: Date)
}

final class ChooseDateViewController: UIViewController {

    @IBOutlet private weak var chooseDatePicker: UIDatePicker!
    
    weak var delegate: ChooseDateDelegate?
    private var chooseDate = Date()
    var countryCovids = [CountryCovid]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChooseDatePicker()
    }
    
    private func setupChooseDatePicker() {
        if !countryCovids.isEmpty {
            let min = countryCovids.first?.date.subStringTime() ?? ""
            let max = countryCovids.last?.date.subStringTime() ?? ""
            chooseDatePicker.setMinMaxTime(min: min, max: max)
        }
    }
    
    @IBAction
    private func onChooseDatePicker(_ sender: UIDatePicker) {
        chooseDate = sender.date
    }
    
    @IBAction
    private func clickOkButton(_ sender: UIButton) {
        delegate?.sendDate(date: chooseDate)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction
    private func clickCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
