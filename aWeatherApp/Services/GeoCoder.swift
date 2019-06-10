//
//  GeoCoder.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import CoreLocation
import ReactiveKit

protocol GeoCoderProtocol {
    func reverseGeocodeLocation(_ location: CLLocation,
                                preferredLocale: Locale?,
                                completionHandler: @escaping CLGeocodeCompletionHandler)
    func cancelGeocode()
}

extension CLGeocoder: GeoCoderProtocol {}

class GeoCoder {
    
    let goeCoder: GeoCoderProtocol
    
    init(goeCoder: GeoCoderProtocol = CLGeocoder()) {
        self.goeCoder = goeCoder
    }
    
    func reverseLocation(location: CLLocation, locale: Locale = Locale.current) -> Signal<CLPlacemark, Error> {
        return Signal<CLPlacemark, Error> { observer in
            self.goeCoder.reverseGeocodeLocation(
                location,
                preferredLocale: locale,
                completionHandler: { placemarks, error in
                    if let error = error {
                        observer.failed(error)
                    } else if let placemark = placemarks?.last {
                        observer.completed(with: placemark)
                    }
            })
            return BlockDisposable {
                self.goeCoder.cancelGeocode()
            }
        }
    }
}
