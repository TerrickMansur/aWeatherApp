//
//  City.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation

class City {
    let name: String
    let countryISOCode: String
    var weatherInfo: WeatherInfo?
    
    init(name: String, countryISOCode: String, weatherInfo: WeatherInfo? = nil) {
        self.name = name
        self.countryISOCode = countryISOCode
        self.weatherInfo = weatherInfo
    }
}
