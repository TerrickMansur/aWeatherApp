//
//  WeatherInfo.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation

struct WeatherInfo: Codable {
    
    let id: Int?
    let name: String?
    let cod: Int?
    
    let weather: [Weather]?
    let main: Main?
    let wind: Wind?
    let clouds: Clouds?
    let sys: Sys?
}
