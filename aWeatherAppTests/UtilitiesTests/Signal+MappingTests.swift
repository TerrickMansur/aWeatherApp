//
//  Signal+MappingTests.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit
import Foundation
import Quick
import Nimble
import ReactiveKit

@testable import aWeatherApp

class SignalMappingTests: QuickSpec {
    override func spec() {
        
        describe("toWeatherInfoModel") {
            it("maps Data to WeatherInfo with correct data") {
                let data = Property<Data>(self.loadJSONFile(file: "weatherinfo_test_data"))

                waitUntil { done in
                    let tempBag = DisposeBag()
                    data.toSignal().toWeatherInfoModel().observeNext { weatherInfo in
                        expect(weatherInfo.id).to(equal(1907296))
                        expect(weatherInfo.name).to(equal("Tawarano"))
                        expect(weatherInfo.cod).to(equal(200))
                    }.dispose(in: tempBag)
                    done()
                }
            }
        }
        
        describe("toTempratureAndIcon") {
            it("maps WeatherInfo to toTempratureAndIcon") {
                let weatherInfo = Property<WeatherInfo>(self.testWeatherInfoModel())

                waitUntil { done in
                    let tempBag = DisposeBag()
                    weatherInfo.toSignal().toTempratureAndIcon(iconsLocation: "http://www.testing.com/").observeNext { tempratureAndIcon in
                        expect(tempratureAndIcon.temprature).to(equal(285.514))
                        expect(tempratureAndIcon.icon).to(equal(URL(string: "http://www.testing.com/01n.png")))
                    }.dispose(in: tempBag)
                    done()
                }
            }
        }
    }
}
