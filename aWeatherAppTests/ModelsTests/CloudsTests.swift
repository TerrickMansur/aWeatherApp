//
//  CloudsTests.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import aWeatherApp

class CloudsTests: QuickSpec {
    
    var clouds: Clouds!
    
    override func spec() {
        describe("Clouds") {
            
            beforeEach {
                let decoder = JSONDecoder()
                do {
                    self.clouds = try decoder.decode(
                        Clouds.self,
                        from: self.loadJSONFile(file: "clouds_test_data"))
                } catch {
                    self.clouds = nil
                }
            }
            
            it("it can be decoded correctly with all data present given correctly") {
                expect(self.clouds.all).to(equal(43))
            }
        }
    }
}
