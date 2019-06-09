//
//  CityTableViewCellViewModelType.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/9/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import ReactiveKit

class CityTableViewCellViewModel: CityTableViewCellViewModelType {

    // MARK: CityTableViewCellViewModelType
    let cityName: String
    let countryISOCode: String
    let temprature: String
    let weatherIconUrl: URL?

    init(cityName: String,
         countryISOCode: String,
         temprature: String,
         weatherIcon: String,
         imagesLocation: String = Configuration.IMAGES_LOCATION) {
        
        self.cityName = cityName
        self.countryISOCode = countryISOCode
        self.temprature = temprature
        self.weatherIconUrl = URL(string: "\(imagesLocation)\(weatherIcon).png")
    }
    
    convenience init(weatherInfo: WeatherInfo) {
        
        var tempratureDisplay = "NA"
        if let temp = weatherInfo.main?.temp {
            tempratureDisplay = "\(temp)"
        }
        
        self.init(cityName: weatherInfo.name ?? "NA",
                  countryISOCode: weatherInfo.sys?.country ?? "NA",
                  temprature: tempratureDisplay,
                  weatherIcon: weatherInfo.weather?.first?.icon ?? "")
    }
}
