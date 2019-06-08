//
//  SysTests.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import aWeatherApp

class SysTests: QuickSpec {
   
    var sys: Sys!
    
    override func spec() {
        describe("Sys") {
            
            beforeEach {
                let decoder = JSONDecoder()
                do {
                    self.sys = try decoder.decode(
                        Sys.self,
                        from: self.loadJSONFile(file: "sys_test_data"))
                } catch {
                    self.sys = nil
                }
            }
            
            it("it can be decoded correctly with all data present given correctly") {
                expect(self.sys.country).to(equal("JP"))
                expect(self.sys.sunrise).to(equal(1485726240))
                expect(self.sys.sunset).to(equal(1485763863))
                expect(self.sys.message).to(equal(0.0025))
            }
        }
    }
}
