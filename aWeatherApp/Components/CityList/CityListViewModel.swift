//
//  CityListViewModel.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation

class CityListViewModel: CityListViewModelType {

    // MARK: CityListViewModelType
    var numberOfRowsInSection: Int {
        return 1
    }

    var numberOfSection: Int {
        return 2
    }
    
    init() {
        
    }
}
