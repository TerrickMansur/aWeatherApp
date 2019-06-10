//
//  AppDelegate.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit
import ReactiveKit
import Bond

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let cities = [
        City(name: "sda", countryISOCode: "gh"),
        City(name: "Oranjestad", countryISOCode: "AW"),
        City(name: "New York", countryISOCode: "US"),
        City(name: "Tokyo", countryISOCode: "JP"),
    ]
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let subject = PublishSubject<City?, Error>()
        
        let distinctLocation = LocationTracker().observeLocation().distinctUntilChanged { lhsLocation, rhsLocation in
            return lhsLocation.coordinate.latitude == rhsLocation.coordinate.latitude
            && lhsLocation.coordinate.longitude == rhsLocation.coordinate.longitude
        }
        
        distinctLocation.observeNext { location in
            let geoCoder = GeoCoder()
            geoCoder.reverseLocation(location: location)
                .toCity().observeNext { city in
                subject.next(city)
            }.dispose(in: self.bag)
        }.dispose(in: self.bag)

        let list = Component.Factory.cityList(
            cities: cities,
            userCitySignal: subject.toSignal(),
            signalForTampratureAndIcon: { city in
                return WeatherEndpoint(city: city.name, isoCountryCode: city.countryISOCode)
                    .signal()
                    .endpointToTempratureAndIcon()
        })

        window?.rootViewController = list.viewController

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

