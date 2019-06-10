//
//  Factory+CloudsInfo.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation

typealias CloudsInfo = (viewController: CouldsInfoViewController, viewModel: CloudsInfoViewModel)

extension Component.Factory {
    static func cloudsInfo(clouds: Clouds) -> CloudsInfo {
        let viewModel = CloudsInfoViewModel(clouds: clouds)
        let viewController: CouldsInfoViewController = .create(viewModelProvider: { vc in
            return viewModel
        })
        
        return (viewController: viewController, viewModel: viewModel)
    }
}
