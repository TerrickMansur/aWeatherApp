//
//  CityListViewModelTests.swift
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

fileprivate let temprature = PublishSubject<TempratureAndIcon, Error>()

class CityListViewModelTests: QuickSpec {

    let cities = [
        City(name: "Oranjestad", countryISOCode: "AW"),
        City(name: "New York", countryISOCode: "US"),
        City(name: "Amsterdam", countryISOCode: "NL"),
    ]
 
    let userCity = PublishSubject<City?, Never>()
    let signalForTemprature: (City) -> Signal<TempratureAndIcon, Error> = { city in
        return temprature.toSignal()
    }
    
    var viewModel: CityListViewModel!
    
    override func spec() {
        describe("CityListViewModel") {
            
            context("when initialized and user location not set yet") {
                beforeEach {
                    self.viewModel = CityListViewModel(cities: self.cities,
                                                       userCity: self.userCity.toSignal(),
                                                       signalForTampratureAndIcon: self.signalForTemprature)
                }

                it("has one section and three rows") {
                    expect(self.viewModel.numberOfSection).to(equal(1))
                    expect(self.viewModel.numberOfRowsInSection(section: 0)).to(equal(3))
                }
                
                it("triggers content did update when we send in a new user city") {
                    waitUntil { done in
                        let tempBag = DisposeBag()
                        self.viewModel.contentDidUpdate.observeNext {
                            done()
                        }.dispose(in: tempBag)
                        self.userCity.next(City.init(name: "Tokyo", countryISOCode: "JP"))
                    }
                }
                
                it("returns the correct cellViewModel cities given the indexPath") {
                    let cellViewModel0 =
                        self.viewModel.cellViewModelFor(indexPath: IndexPath(row: 0, section: 0))
                    
                    expect(cellViewModel0.cityName).to(equal("Oranjestad"))
                    expect(cellViewModel0.countryISOCode).to(equal("AW"))

                    let cellViewModel1 =
                        self.viewModel.cellViewModelFor(indexPath: IndexPath(row: 1, section: 0))
                    
                    expect(cellViewModel1.cityName).to(equal("New York"))
                    expect(cellViewModel1.countryISOCode).to(equal("US"))

                    let cellViewModel2 =
                        self.viewModel.cellViewModelFor(indexPath: IndexPath(row: 2, section: 0))
                    
                    expect(cellViewModel2.cityName).to(equal("Amsterdam"))
                    expect(cellViewModel2.countryISOCode).to(equal("NL"))
                }
                
                it("constructs calls the signalForTampratureAndIcon with correct parameters") {
                    let cellViewModel0 =
                        self.viewModel.cellViewModelFor(indexPath: IndexPath(row: 0, section: 0))

                    waitUntil { done in
                        let tempBag = DisposeBag()
                        cellViewModel0.display.skip(first: 1).observeNext { state in
                            expect(state.value?.temprature).to(equal("12.42"))
                            expect(state.value?.icon).to(equal(URL(fileURLWithPath: "http://www.testing.com/icon.png")))
                            done()
                        }.dispose(in: tempBag)
                        temprature.next((temprature: 12.42, icon: URL(fileURLWithPath: "http://www.testing.com/icon.png")))
                    }
                }
            }
            
            context("when the user city is set") {
                beforeEach {
                    self.viewModel = CityListViewModel(cities: self.cities,
                                                       userCity: self.userCity.toSignal(),
                                                       signalForTampratureAndIcon: self.signalForTemprature)
                    self.userCity.next(City.init(name: "Tokyo", countryISOCode: "JP"))
                }

                it("has two section first with one row, the second with three rows") {

                    expect(self.viewModel.numberOfSection).to(equal(2))
                    expect(self.viewModel.numberOfRowsInSection(section: 0)).to(equal(1))
                    expect(self.viewModel.numberOfRowsInSection(section: 1)).to(equal(3))
                }
                
                it("the user city to be alsone in the first section and the static cities in the other ones") {
                    let cellViewModel00 =
                        self.viewModel.cellViewModelFor(indexPath: IndexPath(row: 0, section: 0))
                    
                    expect(cellViewModel00.cityName).to(equal("Tokyo"))
                    expect(cellViewModel00.countryISOCode).to(equal("JP"))
                    
                    let cellViewModel10 =
                        self.viewModel.cellViewModelFor(indexPath: IndexPath(row: 0, section: 1))
                    
                    expect(cellViewModel10.cityName).to(equal("Oranjestad"))
                    expect(cellViewModel10.countryISOCode).to(equal("AW"))
                    
                    let cellViewModel11 =
                        self.viewModel.cellViewModelFor(indexPath: IndexPath(row: 1, section: 1))
                    
                    expect(cellViewModel11.cityName).to(equal("New York"))
                    expect(cellViewModel11.countryISOCode).to(equal("US"))
                    
                    let cellViewModel12 =
                        self.viewModel.cellViewModelFor(indexPath: IndexPath(row: 2, section: 1))
                    
                    expect(cellViewModel12.cityName).to(equal("Amsterdam"))
                    expect(cellViewModel12.countryISOCode).to(equal("NL"))
                }
            }
        }
    }
}
