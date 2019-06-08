//
//  CouldsInfoViewController.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit

protocol CloudsInfoViewModelType {
    var percentage: String { get }
}

class CouldsInfoViewController: UIViewController, Componentable {
 
    // MARK: IBOutlets
    @IBOutlet private var percentage: UILabel!
    
    // MARK: Componentable
    static var storyboard: String = "CloudsInfo"
    
    var viewModel: CloudsInfoViewModelType! {
        didSet {
            percentage.text = self.viewModel.percentage
        }
    }
}
