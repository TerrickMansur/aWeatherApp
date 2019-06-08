//
//  WindInfoViewModel.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation

class WindInfoViewModel: WindInfoViewModelType {

    // MARK: WindInfoViewModelType
    let speed: String
    let degrees: String
    
    init(speed: String, degrees: String) {
        self.speed = speed
        self.degrees = degrees
    }
    
    convenience init(wind: Wind) {
        var displaySpeed = "NA"
        var displayDegrees = "NA"

        if let speed = wind.speed { displaySpeed = "\(speed)"}
        if let deg = wind.deg { displayDegrees = "\(deg)"}

        self.init(speed: "\(displaySpeed)", degrees: "\(displayDegrees)")
    }
}
