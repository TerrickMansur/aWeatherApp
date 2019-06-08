//
//  WindInfoViewController.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit

protocol WindInfoViewModelType {
    var speed: String { get }
    var degrees: String { get }
}

class WindInfoViewController: UIViewController, Componentable {

    // MARK: IBOutlets
    @IBOutlet private var degrees: UILabel!
    @IBOutlet private var speed: UILabel!

    // MARK: Componentable
    static var storyboard: String = "WindInfo"

    var viewModel: WindInfoViewModelType! {
        didSet {
            degrees.text = self.viewModel.degrees
            speed.text = self.viewModel.speed
        }
    }
}
