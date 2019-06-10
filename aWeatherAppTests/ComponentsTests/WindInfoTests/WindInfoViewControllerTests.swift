//
//  WindInfoViewControllerTests.swift
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

class WindInfoViewControllerTests: QuickSpec {

    var windInfo: WindInfo!

    override func spec() {
        describe("WindInfoViewController") {
            
            context("Initialized with random speed and degrees") {
                beforeEach {
                    self.windInfo = Component.Factory.windInfo(speed: "what", degrees: "makes no sense")
                }
                
                it("should always show whatever its view model has as its value") {
                    
                    let speedValueLabel =
                        self.windInfo.viewController.view
                            .findSubView(restorationIdentifier: "speedLabel")?
                            .asLabel()

                    let degreesValueLabel =
                        self.windInfo.viewController.view
                            .findSubView(restorationIdentifier: "degreesLabel")?
                            .asLabel()
                    
                    expect(degreesValueLabel?.text).to(equal("makes no sense"))
                    expect(speedValueLabel?.text).to(equal("what"))
                }
            }
            
            context("Initialized with wind model") {
                beforeEach {
                    self.windInfo = Component.Factory.windInfo(wind: self.testWindModel())
                }

                it("should set the correct values ") {
                    let speedValueLabel =
                        self.windInfo.viewController.view
                            .findSubView(restorationIdentifier: "speedLabel")?
                            .asLabel()
                    
                    let degreesValueLabel =
                        self.windInfo.viewController.view
                            .findSubView(restorationIdentifier: "degreesLabel")?
                            .asLabel()
                    
                    expect(degreesValueLabel?.text).to(equal("311"))
                    expect(speedValueLabel?.text).to(equal("5.52"))
                }
            }
        }
    }
}
