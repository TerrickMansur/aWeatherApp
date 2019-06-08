//
//  TestWindModel.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import XCTest

@testable import aWeatherApp

extension XCTestCase {
    func testWindModel(file: String = "wind_test_data") -> Wind {
        var wind: Wind!
        let decoder = JSONDecoder()
        do {
            wind = try decoder.decode(
                Wind.self,
                from: self.loadJSONFile(file: file))
        } catch {
            fatalError("Could not load file")
        }
        return wind
    }
}
