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
        
        let tempAndIconSubject = Subject<TempratureAndIcon, Error>()
        var viewModel: CityTableViewCellViewModel!
        
        describe("CityTableViewCellViewModel") {
            
            context("Simple using the pure init") {
                beforeEach {
                    viewModel = CityTableViewCellViewModel(
                        cityName: "city name",
                        countryISOCode: "iso code",
                        tempratureAndIcon: tempAndIconSubject.toSignal())
                }
                
                it("intializes all its attributes correctly given the passed in info") {
                    expect(viewModel.cityName).to(equal("city name"))
                    expect(viewModel.countryISOCode).to(equal("iso code"))
                }
                
                it("will have the display loading state loading initialy") {
                    let tempBag = DisposeBag()
                    waitUntil { done in
                        viewModel.display.observeNext { state in
                            expect(state.isLoading).to(beTrue())
                            done()
                        }.dispose(in: tempBag)
                    }
                    tempBag.dispose()
                }

                it("will have a diplsy signal that gives the correct 'NA' and nil url when items are nil") {
                    let tempBag = DisposeBag()
                    waitUntil { done in
                        viewModel.display.skip(first: 1).observeNext { state in
                            expect(state.isLoading).to(beFalse())
                            expect(state.value?.temprature).to(equal("NA"))
                            expect(state.value?.icon).to(beNil())
                            done()
                        }.dispose(in: tempBag)
                        tempAndIconSubject.next((temprature: nil, icon: nil))
                        tempBag.dispose()
                    }
                }
                
                it("will have a diplsy signal that gives the correct 'NA' and nil url when items are nil") {
                    let tempBag = DisposeBag()
                    waitUntil { done in
                        viewModel.display.skip(first: 1).observeNext { state in
                            expect(state.isLoading).to(beFalse())
                            expect(state.value?.temprature).to(equal("12.12"))
                            expect(state.value?.icon).to(equal(URL(string: "http://www.google.com/icon.png")))
                            done()
                        }.dispose(in: tempBag)
                        tempAndIconSubject.next((temprature: 12.12, icon: URL(string: "http://www.google.com/icon.png")))
                        tempBag.dispose()
                    }
                }

            }
        }
    }
}
