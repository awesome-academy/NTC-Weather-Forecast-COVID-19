//
//  ViewController.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/27/21.
//

import UIKit

final class Covid19ViewController: UIViewController {
    
    @IBOutlet weak private var infectedWorldLabel: UILabel!
    @IBOutlet weak private var deathWorldLabel: UILabel!
    @IBOutlet weak private var recoveredWorldLabel: UILabel!
    @IBOutlet weak private var nameCountryTextField: UITextField!
    @IBOutlet weak private var timeCountryLabel: UILabel!
    @IBOutlet weak private var infectedCoutryLabel: UILabel!
    @IBOutlet weak private var deathCoutryLabel: UILabel!
    @IBOutlet weak private var recoveredCoutryLabel: UILabel!
    
    private var country = Country()
    private var globalCovid = GlobalCovid()
    private var countryCovids = [CountryCovid]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameCountryTextField.isEnabled = false
        loadAPI()
    }
    
    private func loadAPI() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Covid19APIService.shared.getGlobalCovid { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let globalCovid):
                self.globalCovid = globalCovid
                dispatchGroup.leave()
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.enter()
        Covid19APIService.shared.getCountryCovid(slug: country.slug) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let countryCovids):
                self.countryCovids = countryCovids
                dispatchGroup.leave()
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.loadData()
        }
    }
    
    private func loadData() {
        infectedWorldLabel.text = globalCovid.global.totalConfirmed.toString()
        deathWorldLabel.text = globalCovid.global.totalDeaths.toString()
        recoveredWorldLabel.text = globalCovid.global.totalRecovered.toString()
        
        if !countryCovids.isEmpty {
            let countryCovid = countryCovids.last
            timeCountryLabel.text = countryCovid?.date.subStringTime()
            infectedCoutryLabel.text = countryCovid?.confirmed.toString()
            deathCoutryLabel.text = countryCovid?.deaths.toString()
            recoveredCoutryLabel.text = countryCovid?.recovered.toString()
            nameCountryTextField.text = countryCovid?.country
        } else {
            let errorAlert = UIAlertController().showErrorAlert(title: "Notice",
                                                                message: "Not data Covid of this Country!")
            present(errorAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction
    private func clickSearchCountryButton(_ sender: UIButton) {
        performSegue(withIdentifier: "SearchCountryViewController", sender: nil)
    }
    
    @IBAction
    private func clickSeeDetailButton(_ sender: UIButton) {
        if let detailCountryCovidScreen = storyboard?.instantiateViewController(identifier: "DetailCountryCovidViewController")
            as? DetailCovidViewController {
            detailCountryCovidScreen.countryCovids = countryCovids
            detailCountryCovidScreen.country = country
            navigationController?.pushViewController(detailCountryCovidScreen, animated: true)
        } else {
            print("Error click See Detail")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SearchCountryViewController {
            controller.delegate = self
        }
    }
}

extension Covid19ViewController: SearchCountryDelegate {
    func sendCountry(country: Country) {
        self.country = country
        nameCountryTextField.text = country.name
        loadAPI()
    }
}
