//
//  CityListViewControllerTests.swift
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

fileprivate class TestableCityListViewModel: CityListViewModelType {
    var title: String = "Test"
    var contentDidUpdate: Signal<Void, Never>
    var numberOfSection: Int = 88

    func titleForSection(section: Int) -> String {
        return "Test"
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return 25
    }
    
    func cellViewModelFor(indexPath: IndexPath) -> CityTableViewCellViewModelType {
        return CityTableViewCellViewModel(cityName: "city",
                                          countryISOCode: "code",
                                          tempratureAndIcon: Signal.never())
    }
    
    init(contentDidUpdate: Signal<Void, Never>) {
        self.contentDidUpdate = contentDidUpdate
    }
}

class CityListViewControllerTests: QuickSpec {
    
    var contentDidUpdateSubject = PublishSubject<Void, Never>()
    fileprivate var viewModel: TestableCityListViewModel!
    var viewController: CityListViewController!
    var tableView: UITableView!
    
    override func spec() {
        describe("CityListViewController") {
            beforeEach {
                self.viewModel = TestableCityListViewModel(contentDidUpdate: self.contentDidUpdateSubject.toSignal())
                self.viewController = CityListViewController.create(viewModelProvider: { vc in
                    return self.viewModel
                })
                
                self.tableView = self.viewController.view.findSubView(restorationIdentifier: "tableView")?.asTableView()
            }
            
            it("returns the viewModel its section title") {
                expect(self.viewController.tableView(self.tableView, titleForHeaderInSection: 0)).to(equal("Test"))
            }
            
            it("has same number of section and row given by the vm") {
                expect(self.viewController.numberOfSections(in: self.tableView)).to(equal(88))
                expect(self.viewController.tableView(self.tableView, numberOfRowsInSection: 0)).to(equal(25))
            }
            
            it("should be able to dequeue cells of type 'CityTableViewCell' with the correct cell view model assigned") {
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = self.viewController.tableView(self.tableView, cellForRowAt: indexPath)

                expect(cell is CityTableViewCell).to(beTrue())
                expect((cell as? CityTableViewCell)?.viewModel is CityTableViewCellViewModel).to(beTrue())                
            }
        }
    }
}
