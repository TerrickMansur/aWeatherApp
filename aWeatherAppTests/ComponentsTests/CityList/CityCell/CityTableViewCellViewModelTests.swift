//
//  CityTableViewCellViewModelTests.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/9/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit
import Foundation
import Quick
import Nimble
import ReactiveKit

@testable import aWeatherApp

class CityTableViewCellViewModelTests: QuickSpec {
    override func spec() {
        
        var viewModel: CityTableViewCellViewModel!
        
        describe("CityTableViewCellViewModel") {
            
            context("Simple using the pure init") {
                beforeEach {
                    viewModel = CityTableViewCellViewModel(
                        cityName: "city name",
                        countryISOCode: "iso code",
                        temprature: "temprature",
                        weatherIcon: "weather_icon",
                        imagesLocation: "http://www.location.com/")
                }
                
                it("intializes all its attributes correctly given the passed in info") {
                    expect(viewModel.cityName).to(equal("city name"))
                    expect(viewModel.countryISOCode).to(equal("iso code"))
                    expect(viewModel.temprature).to(equal("temprature"))
                    expect(viewModel.weatherIconUrl).to(equal(URL(string: "http://www.location.com/weather_icon.png")))
                }
            }
            
            context("using the convinience init with the model weathe info") {
                beforeEach {
                    viewModel = CityTableViewCellViewModel(weatherInfo: self.testWeatherInfoModel())
                }
                
                it("intializes all its attributes correctly given when using the convinience init") {
                    expect(viewModel.cityName).to(equal("Tawarano"))
                    expect(viewModel.countryISOCode).to(equal("JP"))
                    expect(viewModel.temprature).to(equal("\(285.514)"))
                    expect(viewModel.weatherIconUrl).to(equal(URL(string: "\(Configuration.IMAGES_LOCATION)01n.png")))
                }
            }
        }
    }
}
