//
//  WindInfoViewModelTest.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit
import Foundation
import Quick
import Nimble

@testable import aWeatherApp

class WindInfoViewModelTests: QuickSpec {
    
    var windInfoViewModel: WindInfoViewModel!
    
    override func spec() {
        describe("WindInfoViewModel") {
            
            context("Initialized with random speed and degrees") {
                beforeEach {
                    self.windInfoViewModel = WindInfoViewModel(speed: "what", degrees: "makes no sense")
                }
                
                it("should set its properties correctly") {
                    expect(self.windInfoViewModel.degrees).to(equal("makes no sense"))
                    expect(self.windInfoViewModel.speed).to(equal("what"))
                }
            }
            
            context("Initialized with wind model") {
                beforeEach {
                    self.windInfoViewModel = WindInfoViewModel(wind: self.testWindModel())
                }
                
                it("should set its properties correctly") {
                    expect(self.windInfoViewModel.degrees).to(equal("311"))
                    expect(self.windInfoViewModel.speed).to(equal("5.52"))
                }
            }
            
            context("Initialized but data is empty") {
                beforeEach {
                    self.windInfoViewModel = WindInfoViewModel(wind: self.testWindModel(file: "no_data"))
                }
                
                it("should set its missing properties to NA") {
                    expect(self.windInfoViewModel.degrees).to(equal("NA"))
                    expect(self.windInfoViewModel.speed).to(equal("NA"))
                }
            }
        }
    }
}
