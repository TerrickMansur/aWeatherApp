//
//  CityTableViewCell.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit
import ReactiveKit
import Bond
import SDWebImage

protocol CityTableViewCellViewModelType {
    var cityName: String { get }
    var countryISOCode: String { get }
    var temprature: String { get }
    var weatherIconUrl: URL? { get }
}

class CityTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet private var cityName: UILabel!
    @IBOutlet private var countryISOCode: UILabel!
    @IBOutlet private var weatherIcon: UIImageView!
    @IBOutlet private var temprature: UILabel!

    var viewModel: CityTableViewCellViewModelType! {
        didSet {

            cityName.text = self.viewModel.cityName
            countryISOCode.text = self.viewModel.countryISOCode
            temprature.text = self.viewModel.temprature

            weatherIcon.sd_setImage(with:  self.viewModel.weatherIconUrl,
                                    placeholderImage: UIImage(named: "placeholder.png"))
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.bag.dispose()
    }
}
