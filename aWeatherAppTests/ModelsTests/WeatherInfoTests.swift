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
                let decoder = JSONDecoder()
                do {
                    self.weatherInfo = try decoder.decode(
                        WeatherInfo.self,
                        from: self.loadJSONFile(file: "weatherinfo_test_data"))
                } catch {
                    self.weatherInfo = nil
                }
            }

            it("it can be decoded correctly with all data present given correctly") {

                expect(self.weatherInfo.id).to(equal(1907296))
                expect(self.weatherInfo.cod).to(equal(200))
                expect(self.weatherInfo.name).to(equal("Tawarano"))

                expect(self.weatherInfo.weather).toNot(beNil())
                expect(self.weatherInfo.weather?.count).to(equal(1))
                expect(self.weatherInfo.clouds).toNot(beNil())
                expect(self.weatherInfo.sys).toNot(beNil())
                expect(self.weatherInfo.clouds).toNot(beNil())
                expect(self.weatherInfo.main).toNot(beNil())
            }
        }
    }
}
