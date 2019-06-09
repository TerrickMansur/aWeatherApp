//
//  WeatherIcon.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/9/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import Alamofire

class WeatherIconEndpoint: Endpoint {
    
    // MARK: Endpoint
    let location: String
    let method: HTTPMethod = .get
    let parameters: [String : Any] = [:]
    let encoding: URLEncoding = .default
    let sessionHeader: [String : String]? = nil
    
    init(icon: String,
         imagesLocation: String = Configuration.IMAGES_LOCATION) {
        self.location = "\(imagesLocation)\(icon).png"
    }
}
