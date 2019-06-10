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
        userCitySignal: Signal<City?, Error>,
        signalForTampratureAndIcon: @escaping (City) -> Signal<TempratureAndIcon, SomeError>) -> CityList {
        
        var viewModel: CityListViewModel!

        let viewController: CityListViewController = .create { vc in
            viewModel = CityListViewModel(
            cities: cities,
            userCity: userCitySignal,
            didSelectIndexPath: vc.output.didSelectIndexPath,
            signalForTampratureAndIcon: signalForTampratureAndIcon)
            return viewModel
        }
        
        return (viewController: viewController, viewModel: viewModel)
    }
}
