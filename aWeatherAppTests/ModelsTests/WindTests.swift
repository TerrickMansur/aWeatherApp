//
//  WindTests.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import aWeatherApp

class WindTests: QuickSpec {

    var wind: Wind!
    
    override func spec() {
        describe("Wind") {
            
            beforeEach {
                let decoder = JSONDecoder()
                do {
                    self.wind = try decoder.decode(
                        Wind.self,
                        from: self.loadJSONFile(file: "wind_test_data"))
                } catch {
                    self.wind = nil
                }
            }
            
            it("it can be decoded correctly with all data present given correctly") {
                expect(self.wind.speed).to(equal(5.52))
                expect(self.wind.deg).to(equal(311))
            }
        }
    }
}
