//
//  TestCloudsModel.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import XCTest

@testable import aWeatherApp

extension XCTestCase {
    func testCloudsModel(file: String = "clouds_test_data") -> Clouds {
        var clouds: Clouds!
        let decoder = JSONDecoder()
        do {
            clouds = try decoder.decode(
                Clouds.self,
                from: self.loadJSONFile(file: file))
        } catch {
            fatalError("Could not load file")
        }
        return clouds
    }
}
