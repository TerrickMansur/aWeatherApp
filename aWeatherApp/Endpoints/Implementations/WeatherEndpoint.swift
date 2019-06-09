//
//  Weather.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherEndpoint: Endpoint {
    
    // MARK: Endpoint
    let location: String
    let method: HTTPMethod = .get
    let parameters: [String : Any]
    let encoding: URLEncoding = .default
    let sessionHeader: [String : String]? = nil
    
    init(city: String,
         isoCountryCode: String? = nil,
         apiLocation: String = Configuration.API_URL,
         appId: String = Configuration.APP_ID) {

        var isoToInsert = ""
        if let isoCountryCode = isoCountryCode {
            isoToInsert = ",\(isoCountryCode)"
        }

        self.location = "\(apiLocation)weather"
        
        self.parameters = [
            "q": "\(city)\(isoToInsert)",
            "APPID": appId]
    }
}
