//
//  Signal+Mapping.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import ReactiveKit
import CoreLocation

class SomeError: Error {}

extension Signal where Element == Data {
    func endpointToTempratureAndIcon() -> Signal<TempratureAndIcon, SomeError> {
        return self.toWeatherInfoModel()
            .toTempratureAndIcon()
    }
}

extension Signal where Element == Data {

    func toWeatherInfoModel() -> Signal<WeatherInfo, SomeError> {
        return Signal<WeatherInfo, SomeError> { observer in
            return self.observe { event in
                switch event {
                case .next(let data):
                var weatherInfo: WeatherInfo!
                let decoder = JSONDecoder()
                do { weatherInfo = try decoder.decode(WeatherInfo.self, from: data)
                    observer.next(weatherInfo)
                } catch {
                    observer.failed(SomeError())
                }
                case .failed(_): 
                    observer.failed(SomeError())
                case .completed: break
                }
            }
        }
    }
}

extension Signal where Element == WeatherInfo {
    func toTempratureAndIcon(iconsLocation: String = Configuration.IMAGES_LOCATION) ->
        Signal<TempratureAndIcon, SomeError> {
            return Signal<TempratureAndIcon, SomeError> { observer in
                return self.observe { event in
                    switch event {
                    case .next(let weatherInfoModel):
                    let icon = weatherInfoModel.weather?.first?.icon ?? ""
                    observer.next((
                        temprature: weatherInfoModel.main?.temp_max,
                        icon: URL(string: "\(iconsLocation)\(icon).png")))
                    case .failed(_):
                        observer.failed(SomeError())
                    case .completed: break
                    }
                }
        }
    }
}

extension Signal where Element == CLPlacemark {
    
    func toCity() -> Signal<City, Error> {
        return Signal<City, Error> { observer in
            return self.observe { event in
                switch event {
                case .next(let element):
                    observer.next(City(name: element.subAdministrativeArea ?? "NA", countryISOCode: element.isoCountryCode ?? "NA"))
                case .completed: break
                case .failed: break
                }
            }
        }
    }
}
