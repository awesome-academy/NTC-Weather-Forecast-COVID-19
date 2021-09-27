//
//  WeatherViewControllerTest.swift
//  NTC-Weather-Forecast-COVID-19Tests
//
//  Created by trần nam on 9/22/21.
//

import XCTest
@testable import NTC_Weather_Forecast_COVID_19

class WeatherViewControllerTest: XCTestCase {
    var sut: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testValidApiCallGetsHTTPStatusCode() throws {
        let urlString = "https://615179c54a5f22001701d220.mockapi.io/getCovidGlobal/getCurrentWeather"
        let url = URL(string: urlString)!
        
        let promise = expectation(description: "Status code: 200")
        let dataTask = sut.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        
        wait(for: [promise], timeout: 5)
    }
    
    func testApiCallCompletes() throws {
        let urlString = "https://615179c54a5f22001701d220.mockapi.io/getCovidGlobal/getCurrentWeather"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sut.dataTask(with: url) { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
