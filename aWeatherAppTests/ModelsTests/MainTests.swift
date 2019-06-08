//
//  MainTests.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import aWeatherApp

class MainTests: QuickSpec {
    
    var main: Main!
    
    override func spec() {
        describe("Main") {
            
            beforeEach {
                let decoder = JSONDecoder()
                do {
                    self.main = try decoder.decode(
                        Main.self,
                        from: self.loadJSONFile(file: "main_test_data"))
                } catch {
                    self.main = nil
                }
            }
            
            it("it can be decoded correctly with all data given correct data") {
                expect(self.main.temp).to(equal(285.514))
                expect(self.main.pressure).to(equal(1013.75))
                expect(self.main.humidity).to(equal(100))
                expect(self.main.temp_min).to(equal(285.514))
                expect(self.main.temp_max).to(equal(285.514))
                expect(self.main.sea_level).to(equal(1023.22))
                expect(self.main.grnd_level).to(equal(1013.75))
            }
        }
    }
}

