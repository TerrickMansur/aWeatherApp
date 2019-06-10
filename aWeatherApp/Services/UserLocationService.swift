//
//  UserLocationService.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import CoreLocation
import ReactiveKit

protocol LocationManagerType {
    var delegate: CLLocationManagerDelegate? { get set }
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

extension CLLocationManager: LocationManagerType {}

final class LocationTracker: NSObject, CLLocationManagerDelegate {
    
    // MARK: Privates
    private var locationManager: LocationManagerType
    private let didUpdateLocation = SafePublishSubject<CLLocation>()
    private let didFail = SafePublishSubject<Error>()
    
    init(locationManager: LocationManagerType = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func observeLocation() -> Signal<CLLocation, Error> {
        return Signal<CLLocation, Error> { observer in
            self.locationManager.startUpdatingLocation()
            
            self.didUpdateLocation.observeNext { location in
                observer.next(location)
            }.dispose(in: self.bag)
            
            self.didFail.observeNext { error in
                observer.failed(error)
            }.dispose(in: self.bag)
            
            return BlockDisposable {
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        didUpdateLocation.next(lastLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFail.next(error)
    }
}
