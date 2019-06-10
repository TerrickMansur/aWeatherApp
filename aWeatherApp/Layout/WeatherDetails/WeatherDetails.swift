//
//  WeatherDetailsLayout.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetails: StackLayoutDriver {

    var title: String = "Details"

    let headerViewController: [UIViewController] = []
    let bodyViewController: [UIViewController]
    let footerViewController: [UIViewController] = []
    
    init(wind: Wind?, clouds: Clouds?) {
        
        var bodyViewControllers: [UIViewController] = []
        
        if let wind = wind {
            let windInfo = Component.Factory.windInfo(wind: wind)
            bodyViewControllers.append(windInfo.viewController)
        }
        if let clouds = clouds {
            let cloudInfo = Component.Factory.cloudsInfo(clouds: clouds)
            bodyViewControllers.append(cloudInfo.viewController)
        }
        bodyViewController = bodyViewControllers
        
    }
}
