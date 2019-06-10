//
//  CityListViewModel.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import ReactiveKit

class CityListViewModel: CityListViewModelType {

    let bag = DisposeBag()

    // MARK: CityListViewModelType

    let contentDidUpdate: Signal<Void, Never>

    var numberOfSection: Int {
        var numberOfSection = 0
        if hasUserCity { numberOfSection += 1}
        if hasStaticCities { numberOfSection += 1}
        return numberOfSection
    }
    
    // MARK: Private
    private var userCity: City?
    private let cities: [City]
    private let signalForTampratureAndIcon: (_ city: City) -> (Signal<TempratureAndIcon, Error>)
    
    init(cities: [City],
         userCity: SafeSignal<City?>,
         signalForTampratureAndIcon: @escaping (_ city: City) -> (Signal<TempratureAndIcon, Error>)) {

        self.cities = cities
        contentDidUpdate = userCity.eraseType()
        self.signalForTampratureAndIcon = signalForTampratureAndIcon

        userCity.observeNext { [weak self] city in
            self?.userCity = city
        }.dispose(in: self.bag)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if hasUserCity {
            if section == 0 {
                return 1
            } else {
                return cities.count
            }
        }
        return cities.count
    }
    
    func cellViewModelFor(indexPath: IndexPath) -> CityTableViewCellViewModelType {
        let city = cityForIdexPath(indexPath: indexPath)

        return CityTableViewCellViewModel(
            cityName: city.name,
            countryISOCode: city.countryISOCode,
            tempratureAndIcon: signalForTampratureAndIcon(city))
    }

    private func cityForIdexPath(indexPath: IndexPath) -> City {
        if hasUserCity {
            if indexPath.section == 0 {
                guard let userCity = self.userCity else { fatalError("If this happens, there is a bug")}
                return userCity
            } else {
                return cities[indexPath.row]
            }
        } else {
            return cities[indexPath.row]
        }
    }
    
    private var hasStaticCities: Bool {
        return self.cities.count > 0
    }
    
    private var hasUserCity: Bool {
        return self.userCity != nil
    }

}
