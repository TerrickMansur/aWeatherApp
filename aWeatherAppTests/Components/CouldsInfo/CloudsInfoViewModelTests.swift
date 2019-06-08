//
//  CloudsInfoViewModelTests.swift
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

class CloudsInfoViewModelTests: QuickSpec {

    var cloudsInfoViewModel: CloudsInfoViewModel!
    
    override func spec() {
        describe("CloudsInfoViewModel") {
            
            context("Initialized with string that might not moke sense") {
                beforeEach {
                    self.cloudsInfoViewModel = CloudsInfoViewModel(percentage: "makes no sense")
                }
                
                it("it should initialize with whatever is given to it") {
                    expect(self.cloudsInfoViewModel.percentage).to(equal("makes no sense"))
                }
            }
            
            context("Initialized with wind model") {
                beforeEach {
                    self.cloudsInfoViewModel = CloudsInfoViewModel(clouds: self.testCloudsModel())
                }
                
                it("should set its properties correctly") {
                    expect(self.cloudsInfoViewModel.percentage).to(equal("43"))
                }
            }
            
            context("Initialized but data is empty") {
                beforeEach {
                    self.cloudsInfoViewModel = CloudsInfoViewModel(clouds: self.testCloudsModel(file: "no_data"))
                }
                
                it("should set its missing properties to NA") {
                    expect(self.cloudsInfoViewModel.percentage).to(equal("NA"))
                }
            }
        }
    }
}
