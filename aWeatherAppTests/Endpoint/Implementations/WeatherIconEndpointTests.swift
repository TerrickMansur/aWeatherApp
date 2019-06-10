//
//  WeatherIconTests.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/9/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire

@testable import aWeatherApp

class WeatherIconEndpointTests: QuickSpec {

    var weatherIcon: WeatherIconEndpoint!
    
    override func spec() {
        describe("WeatherIcon") {
            
            context("when initialized with icon name") {
                
                beforeEach {
                    self.weatherIcon = WeatherIconEndpoint(icon: "lala")
                }
                
                it("it should provide the correct location given the icon name") {
                    expect(self.weatherIcon.location).to(equal("https://openweathermap.org/img/w/lala.png"))
                }
            }
            
            context("when initialized with icon name and some image location ") {
                
                beforeEach {
                    self.weatherIcon = WeatherIconEndpoint(icon: "brap", imagesLocation: "http://www.someoicon.com/")
                }
                
                it("it should provide the correct location given the icon name") {
                    expect(self.weatherIcon.location).to(equal("http://www.someoicon.com/brap.png"))
                }
            }

        }
    }
}
