//
//  WeatherInfoTests.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import aWeatherApp

class WeatherInfoTests: QuickSpec {

    var weatherInfo: WeatherInfo!
    
        override func spec() {
        describe("WeatherInfo") {
            beforeEach {
                self.weatherInfo = WeatherInfo(data: self.loadJSONFile(file: "WeatherInfoTestData"))
            }

            it("initializing it with correct data should populate it correctly") {
            }
        }
    }
}
