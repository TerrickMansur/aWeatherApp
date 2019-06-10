//
//  CityTableViewCellViewModelType.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/9/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import ReactiveKit

typealias TempratureAndIcon = (temprature: Double?, icon: URL?)

class CityTableViewCellViewModel: CityTableViewCellViewModelType {

    // MARK: CityTableViewCellViewModelType
    let cityName: String
    let countryISOCode: String
    var display: LoadingSignal<TempratureAndIconDisplay, SomeError>

    init(cityName: String,
         countryISOCode: String,
         tempratureAndIcon: Signal<TempratureAndIcon, SomeError>) {
        
        self.cityName = cityName
        self.countryISOCode = countryISOCode
        self.display = tempratureAndIcon.map { tempAndIcon in
            var tempratureDisplay = "NA"
            if let tempDis = tempAndIcon.temprature {
                tempratureDisplay = "\(tempDis)"
            }
            return (temprature: tempratureDisplay, icon: tempAndIcon.icon)
        }.toLoadingSignal()
    }
}
