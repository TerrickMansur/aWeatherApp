//
//  Factory+WindInfo.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation

typealias WindInfo = (viewController: WindInfoViewController, viewModel: WindInfoViewModel)

extension Component.Factory {
    static func windInfo(speed: String, degrees: String) -> WindInfo {
        
        let viewModel = WindInfoViewModel(speed: speed, degrees: degrees)
        let viewController: WindInfoViewController = .create(viewModelProvider: { vc in
            return viewModel
        })
        
        return (viewController: viewController, viewModel: viewModel)
    }
    
    static func windInfo(wind: Wind) -> WindInfo {
        let viewModel = WindInfoViewModel(wind: wind)
        let viewController: WindInfoViewController = .create(viewModelProvider: { vc in
            return viewModel
        })
        
        return (viewController: viewController, viewModel: viewModel)
    }

}
