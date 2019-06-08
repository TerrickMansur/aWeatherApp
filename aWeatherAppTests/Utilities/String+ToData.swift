//
//  String+ToData.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation

extension String {
    func toData() -> Data {
        return Data(self.utf8)
    }
}
