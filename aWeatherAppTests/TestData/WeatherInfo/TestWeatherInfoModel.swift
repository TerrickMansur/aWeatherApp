//
//  TestModel.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import XCTest

@testable import aWeatherApp

extension XCTestCase {
    func testWeatherInfoModel(file: String = "weatherinfo_test_data") -> WeatherInfo {
        var weatherInfo: WeatherInfo!
        let decoder = JSONDecoder()
        do {
            weatherInfo = try decoder.decode(
                WeatherInfo.self,
                from: self.loadJSONFile(file: file))
        } catch {
            fatalError("Could not load file")
        }
        return weatherInfo
    }
}
