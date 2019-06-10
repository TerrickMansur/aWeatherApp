//
//  Factory+CityList.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import ReactiveKit

typealias CityList = (viewController: CityListViewController, viewModel: CityListViewModel)

extension Component.Factory {
    static func cityList(
        cities: [City],
        userCitySignal: SafeSignal<City?>,
        signalForTampratureAndIcon: @escaping (City) -> Signal<TempratureAndIcon, Error>) -> CityList {
        
        let viewModel = CityListViewModel(
            cities: cities,
            userCity: userCitySignal,
            signalForTampratureAndIcon: signalForTampratureAndIcon)
        
        let viewController: CityListViewController = .create { vc in
            return viewModel
        }
        
        return (viewController: viewController, viewModel: viewModel)
    }
}
