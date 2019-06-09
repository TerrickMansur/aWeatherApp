//
//  WeatherTests.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/9/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import aWeatherApp

class WeatherTests: QuickSpec {
    
    var weather: Weather!
    
    override func spec() {
        describe("Weather") {
            
            beforeEach {
                let decoder = JSONDecoder()
                do {
                    self.weather = try decoder.decode(
                        Weather.self,
                        from: self.loadJSONFile(file: "weather_test_data"))
                } catch {
                    self.weather = nil
                }
            }
            
            it("it can be decoded correctly with all data present given correctly") {
                expect(self.weather.id).to(equal(801))
                expect(self.weather.description).to(equal("few clouds"))
                expect(self.weather.main).to(equal("Clouds"))
                expect(self.weather.icon).to(equal("02d"))
            }
        }
    }
}
