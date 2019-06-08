//
//  Sys.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation

struct Sys: Codable {
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}
