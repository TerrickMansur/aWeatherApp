//
//  CouldInfoViewController.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit

protocol CloudInfoViewModelType {
    var percentage: String { get }
}

class CouldInfoViewController: UIViewController, Componentable {
 
    // MARK: IBOutlets
    @IBOutlet private var percentage: UILabel!
    
    // MARK: Componentable
    static var storyboard: String = "CloudInfo"
    
    var viewModel: CloudInfoViewModelType! {
        didSet {
            percentage.text = self.viewModel.percentage
        }
    }
}
