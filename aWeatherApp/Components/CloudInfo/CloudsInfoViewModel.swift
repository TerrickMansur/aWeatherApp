//
//  CloudsInfoViewModel.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation

class CloudsInfoViewModel: CloudsInfoViewModelType {
    
    // MARK: CloudInfoViewModelType
    let percentage: String
    
    init(percentage: String) {
        self.percentage = percentage
    }
    
    convenience init(clouds: Clouds) {
        var cloudsPercentage = "NA"
        if let percentage = clouds.all { cloudsPercentage = "\(percentage)"}        
        self.init(percentage: cloudsPercentage)
    }
}
