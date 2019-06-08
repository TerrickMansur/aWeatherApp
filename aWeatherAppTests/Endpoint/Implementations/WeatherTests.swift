//
//  WeatherTests.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire

@testable import aWeatherApp



class WeatherTests: QuickSpec {
    
    var weather: Weather!
    
    override func spec() {
        describe("Weather") {

            context("when initialized with only city name") {

                beforeEach {
                    self.weather = Weather(city: "New York")
                }

                it("it should provide the correct location, method, parameters, and session header") {
                    expect(self.weather.location).to(equal("https://api.openweathermap.org/data/2.5/weather"))
                    expect(self.weather.parameters["q"] as? String).to(equal("New York"))
                    expect(self.weather.parameters["APPID"] as? String).to(equal("b12c1b59bf87ebd28ed930a9c0fec89d"))
                    expect(self.weather.method).to(equal(HTTPMethod.get))
                    expect(self.weather.sessionHeader).to(beNil())
                }
            }
            
            context("when initialized with city name and ISO country code") {
                beforeEach {
                    self.weather = Weather(city: "New York", isoCountryCode: "US")
                }
                
                it("its should provide the correct location, method, session header and the parameters['q'] should also include the country code") {
                    expect(self.weather.location).to(equal("https://api.openweathermap.org/data/2.5/weather"))
                    expect(self.weather.parameters["q"] as? String).to(equal("New York,US"))
                    expect(self.weather.parameters["APPID"] as? String).to(equal("b12c1b59bf87ebd28ed930a9c0fec89d"))
                    expect(self.weather.method).to(equal(HTTPMethod.get))
                    expect(self.weather.sessionHeader).to(beNil())
                }
            }
            
            context("when initialized with different APPID and Api Location, it should use those") {
                beforeEach {
                    self.weather = Weather(city: "New York", isoCountryCode: "US", apiLocation: "somelocation", appId: "someappid")
                }
                
                it("its should provide the correct location, method, session header and the parameters['q'] should also include the country code") {
                    expect(self.weather.location).to(equal("somelocationweather"))
                    expect(self.weather.parameters["q"] as? String).to(equal("New York,US"))
                    expect(self.weather.parameters["APPID"] as? String).to(equal("someappid"))
                    expect(self.weather.method).to(equal(HTTPMethod.get))
                    expect(self.weather.sessionHeader).to(beNil())
                }
            }
        }
    }
}
