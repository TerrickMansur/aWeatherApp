//
//  FileManager+Reader.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import XCTest

extension XCTestCase {
    func loadJSONFile(file: String) -> Data {
        let path = Bundle(for: type(of: self)).path(forResource: file, ofType: "json")!
        return NSData(contentsOfFile: path)! as Data
    }
}
