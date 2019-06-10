//
//  FlowViewController.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit
import ReactiveKit

protocol FlowViewModelProtocol {
    var root: UIViewController { get }
    var show: SafeSignal<UIViewController> { get }
    var present: SafeSignal<FlowController.Presentation> { get }
    var dismiss: SafeSignal<FlowController.Dismissal> { get }
    var goBack: SafeSignal<Void> { get }
}

extension UINavigationController {

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class FlowController: NSObject {
    
    struct Presentation {
        
        let viewController: UIViewController
        let animated: Bool
        let completion: (() -> Void)?
        
        init(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
            self.viewController = viewController
            self.animated = animated
            self.completion = completion
        }
    }
    
    struct Dismissal {
        
        let animated: Bool
        let completion: (() -> Void)?

        init(animated: Bool, completion: (() -> Void)?) {
            self.animated = animated
            self.completion = completion
        }
    }
    
    public let root: UIViewController

    private let navigationController: UINavigationController
    
    // # MARK: Private Attributes

    private let viewModel: FlowViewModelProtocol
    
    init(viewModel: FlowViewModelProtocol, navigationController: UINavigationController? = nil) {
        self.viewModel = viewModel
        
        if let navigationController = navigationController {
            self.navigationController = navigationController
            self.root = self.viewModel.root
        } else {
            self.navigationController = UINavigationController(rootViewController: self.viewModel.root)
            self.root = self.navigationController
        }

        super.init()

        self.viewModel.show.observeNext { [weak self] viewController in
            self?.navigationController.show(viewController, sender: nil)
        }.dispose(in: bag)
        
        self.viewModel.present.observeNext { [weak self] presentation in
            self?.navigationController.present(presentation.viewController, animated: presentation.animated, completion: presentation.completion)
        }.dispose(in: bag)
        
        self.viewModel.goBack.observeNext { [weak self] dismissal in
            self?.navigationController.popViewController(animated: true)
        }.dispose(in: bag)
    }
}
