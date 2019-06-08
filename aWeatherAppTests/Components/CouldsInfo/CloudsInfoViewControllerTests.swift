//
//  CloudsInfoViewControllerTests.swift
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

private class TestableCloudsInfoViewModel: CloudsInfoViewModelType {
    let percentage: String
    init(percentage: String) {
        self.percentage = percentage
    }
}

class CloudsnfoViewControllerTests: QuickSpec {
    
    var cloudInfo: CouldsInfoViewController!
    
    override func spec() {
        describe("CouldsInfoViewController") {
            
            beforeEach {
                self.cloudInfo = CouldsInfoViewController.create(viewModelProvider: { vc in
                    return TestableCloudsInfoViewModel(percentage: "84")
                })
            }
            
            it("should set the text for the percentage label with the corect value") {
                let percentageLabel = self.cloudInfo.view
                    .findSubView(restorationIdentifier: "percentageLabel")?
                    .asLabel()

                expect(percentageLabel?.text).to(equal("84"))
            }
        }
    }
}
