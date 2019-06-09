//
//  CityTableViewCellTests.swift
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

class TestableCityCellViewModel: CityTableViewCellViewModelType {

    var cityName: String = "city name"
    var countryISOCode: String = "country iso"
    var display: LoadingSignal<TempratureAndIconDisplay, Error>
    
    init(displaySubject: PublishSubject<TempratureAndIconDisplay, Error>) {
        self.display = displaySubject.toSignal().toLoadingSignal()
    }
}

class EmptyError: Error {}

class CityTableViewCellTests: QuickSpec {

    let weatherDisplaySubject = PublishSubject<TempratureAndIconDisplay, Error>()
    
    var cell: CityTableViewCell!
    var viewModel: TestableCityCellViewModel!
    
    override func spec() {

        describe("CityTableViewCell") {

            beforeEach {
                let storyboard = UIStoryboard(name: "CityList", bundle: Bundle.main)
                let tableVC = storyboard.instantiateViewController(withIdentifier: "CityList") as? CityListViewController
                let tableView = tableVC?.view.findSubView(restorationIdentifier: "tableView") as? UITableView
                self.cell = tableView?.dequeueReusableCell(withIdentifier: "cityCell") as? CityTableViewCell
                self.viewModel = TestableCityCellViewModel(displaySubject: self.weatherDisplaySubject)
                self.cell.viewModel = self.viewModel
            }
            
            it("will set the none changing label their text correctly") {
                let cityNameLabel = self.cell
                    .findSubView(restorationIdentifier: "cityName")?.asLabel()

                let countryCodeLabel = self.cell
                    .findSubView(restorationIdentifier: "countryISOCode")?.asLabel()

                expect(cityNameLabel?.text).to(equal("city name"))
                expect(countryCodeLabel?.text).to(equal("country iso"))
            }
            
            it("will hide the retry button, stop the loading indicator and set the correct data to the temprature when loaded successfully") {
                
                let retryButton = self.cell
                    .findSubView(restorationIdentifier: "retryButton")?.asButton()
                expect(retryButton?.isHidden).to(beTrue())
                
                let tempratureLabel = self.cell
                    .findSubView(restorationIdentifier: "tempratureLabel")?.asLabel()
                
                let loadingIndicator = self.cell
                    .findSubView(restorationIdentifier: "activityIndicator")?.asActivityIndicatorView()
                
                self.weatherDisplaySubject.next((temprature: "temptemp", icon: URL(string: "http://wwww.test.com/some.png")))
                
                expect(retryButton?.isHidden).to(beTrue())
                expect(tempratureLabel?.text).to(equal("temptemp"))
                expect(loadingIndicator?.isAnimating).to(beFalse())
            }

            it("will set the retry button to hidden, the loading indicator to be animating and the temprature to say loading when loading") {

                let retryButton = self.cell
                    .findSubView(restorationIdentifier: "retryButton")?.asButton()
 
                let tempratureLabel = self.cell
                    .findSubView(restorationIdentifier: "tempratureLabel")?.asLabel()

                let loadingIndicator = self.cell
                    .findSubView(restorationIdentifier: "activityIndicator")?.asActivityIndicatorView()
                
                expect(retryButton?.isHidden).to(beTrue())
                expect(tempratureLabel?.text).to(equal("Loading"))
                expect(loadingIndicator?.isAnimating).to(beTrue())
            }
            
            it("will set the retry button to showing and the loading indicator not animating when the signal fails") {

                let retryButton = self.cell
                    .findSubView(restorationIdentifier: "retryButton")?.asButton()
                expect(retryButton?.isHidden).to(beTrue())
                
                let tempratureLabel = self.cell
                    .findSubView(restorationIdentifier: "tempratureLabel")?.asLabel()

                let loadingIndicator = self.cell
                    .findSubView(restorationIdentifier: "activityIndicator")?.asActivityIndicatorView()
                
                self.weatherDisplaySubject.failed(EmptyError())
                
                expect(retryButton?.isHidden).to(beFalse())
                expect(tempratureLabel?.text).to(equal("Failed"))
                expect(loadingIndicator?.isAnimating).to(beFalse())
            }
        }
    }
}
