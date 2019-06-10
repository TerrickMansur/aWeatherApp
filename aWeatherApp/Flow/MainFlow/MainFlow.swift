//
//  MainFlow.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import ReactiveKit

class MainFlow: FlowViewModelProtocol {

    typealias Root = (viewController: UIViewController, didSelectCity: SafeSignal<City>)

    let root: UIViewController
    let show : SafeSignal<UIViewController>
    let present: SafeSignal<FlowController.Presentation> = .never()
    let dismiss: SafeSignal<FlowController.Dismissal> = .never()
    let goBack: SafeSignal<Void> = .never()
    
    // MARK: Private
    let showSubject = SafePublishSubject<UIViewController>()

    init(rootComponent: Root) {
        self.root = rootComponent.viewController
        
        self.show = rootComponent.didSelectCity.map { city in

            let layout: StackLayoutViewController = .create(style: StackLayoutViewController.Style()) { vc in
                return WeatherDetails(wind: city.weatherInfo?.wind, clouds: city.weatherInfo?.clouds)
            }
            return layout
        }
    }
}
