//
//  Weather.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/9/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
