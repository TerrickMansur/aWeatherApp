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
    var temprature: String = "temp ra ture"
    var weatherIconUrl: URL? = URL(string: "http://www.example.com/10.png")
}

class EmptyError: Error {}

class CityTableViewCellTests: QuickSpec {

    let weatherIconSubject = PublishSubject<Data, Error>()
    
    var cell: CityTableViewCell!
    var viewModel: TestableCityCellViewModel!
    
    override func spec() {

        describe("CityTableViewCell") {

            beforeEach {
                let storyboard = UIStoryboard(name: "CityList", bundle: Bundle.main)
                let tableVC = storyboard.instantiateViewController(withIdentifier: "CityList") as? CityListViewController
                let tableView = tableVC?.view.findSubView(restorationIdentifier: "tableView") as? UITableView
                self.cell = tableView?.dequeueReusableCell(withIdentifier: "cityCell") as? CityTableViewCell
                self.viewModel = TestableCityCellViewModel()
                self.cell.viewModel = self.viewModel
            }
            
            it("will set the none changing label their text correctly") {
                let cityNameLabel = self.cell
                    .findSubView(restorationIdentifier: "cityName")?.asLabel()

                let countryCodeLabel = self.cell
                    .findSubView(restorationIdentifier: "countryISOCode")?.asLabel()
                
                let tempratureLabel = self.cell
                    .findSubView(restorationIdentifier: "tempratureLabel")?.asLabel()

                expect(cityNameLabel?.text).to(equal("city name"))
                expect(countryCodeLabel?.text).to(equal("country iso"))
                expect(tempratureLabel?.text).to(equal("temp ra ture"))
            }
        }
    }
}
