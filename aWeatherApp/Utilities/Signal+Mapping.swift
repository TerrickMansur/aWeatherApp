//
//  Signal+Mapping.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import ReactiveKit

extension Signal where Element == Data {
    func endpointToTempratureAndIcon() -> Signal<TempratureAndIcon, Error> {
        return self.toWeatherInfoModel()
            .toTempratureAndIcon()
    }
}

extension Signal where Element == Data {
    
    func toWeatherInfoModel() -> Signal<WeatherInfo, Error> {
        return self.map { data in 
            var weatherInfo: WeatherInfo!
            let decoder = JSONDecoder()
            do {
                weatherInfo = try decoder.decode(
                    WeatherInfo.self,
                    from: data)
            } catch {
                fatalError("Data must be json")
            }
            return weatherInfo
        }
    }
}

extension Signal where Element == WeatherInfo {
    func toTempratureAndIcon(iconsLocation: String = Configuration.IMAGES_LOCATION) -> Signal<TempratureAndIcon, Error> {
        return self.map { weatherInfoModel in
            let icon = weatherInfoModel.weather?.first?.icon ?? ""
            return (temprature: weatherInfoModel.main?.temp_max,
                    icon: URL(string: "\(iconsLocation)\(icon).png"))
        }
    }
}
