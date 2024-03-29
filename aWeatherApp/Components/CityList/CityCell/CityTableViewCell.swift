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

typealias TempratureAndIconDisplay = (temprature: String, icon: URL?)

protocol CityTableViewCellViewModelType {
    var cityName: String { get }
    var countryISOCode: String { get }
    var display: LoadingSignal<TempratureAndIconDisplay, SomeError> { get }
}

class CityTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet private var cityName: UILabel!
    @IBOutlet private var countryISOCode: UILabel!
    @IBOutlet private var weatherIcon: UIImageView!
    @IBOutlet private var temprature: UILabel!
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private var retryButton: UIButton!

    var viewModel: CityTableViewCellViewModelType! {
        didSet {

            cityName.text = self.viewModel.cityName
            countryISOCode.text = self.viewModel.countryISOCode

            self.viewModel.display.observeNext { [weak self] state in
                self?.updateWithState(state: state)
            }.dispose(in: bag)
            
            retryButton.reactive.tap.flatMapLatest { self.viewModel.display }.observeNext { [ weak self] state in
                self?.updateWithState(state: state)
            }.dispose(in: bag)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag.dispose()
    }
    
    private func updateWithState(state: LoadingState<TempratureAndIconDisplay, SomeError>) {
        switch state {
        case .loading:
        activityIndicatorView.startAnimating()
        retryButton.isHidden = true
        temprature.text = "Loading"
        self.weatherIcon?.image = UIImage(named: "placeholder")
        case .loaded(let data):
        temprature.text = data.temprature
        retryButton.isHidden = true
        activityIndicatorView.stopAnimating()
        weatherIcon.sd_setImage(with: data.icon, placeholderImage: UIImage(named: "placeholder"))
        case .failed:
        temprature.text = "Failed"
        self.weatherIcon?.image = UIImage(named: "placeholder")
        retryButton.isHidden = false
        activityIndicatorView.stopAnimating()
        }
    }
}
