//
//  Layout1.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/10/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit

public protocol LayoutComponent {
    associatedtype GenericDriver
    associatedtype GenericStyle

    static var storyboardName: String { get }

    var driver: GenericDriver! { get set }
    var style: GenericStyle { get set }
}

extension LayoutComponent {
    public static func create<GenericVC: LayoutComponent>(style: GenericStyle, driverGenerator: @escaping (GenericVC) -> GenericDriver) -> GenericVC where GenericVC: UIViewController, GenericDriver == GenericVC.GenericDriver, GenericStyle == GenericVC.GenericStyle {
        let storyboard = UIStoryboard(name: GenericVC.storyboardName, bundle: Bundle(for: GenericVC.self))

        guard var viewController = storyboard.instantiateInitialViewController() as? GenericVC else {
            fatalError("Could not create \(String(describing: GenericVC.self))")
        }
        // Force the viewcontroller to load
        viewController.loadViewIfNeeded()

        viewController.style = style
        viewController.driver = driverGenerator(viewController)

        return viewController as GenericVC // we know for sure that viewController conforms to GenericViewController
    }
}

public protocol StackLayoutDriver {
    var title: String { get }
    var headerViewController: [UIViewController] { get }
    var bodyViewController: [UIViewController] { get }
    var footerViewController: [UIViewController] { get }
}

public final class StackLayoutViewController: UIViewController, LayoutComponent {
    public class Style {
        public init() {
        }

        var headerMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var bodyMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var footerMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    @IBOutlet private var backgroundImage: UIImageView!

    /* WARNING: headerBottom and bodyTop are the same contraint */
    /* WARNING: bodyBottom and footerTop are the same contraint */

    @IBOutlet private var headerStackView: UIStackView!
    @IBOutlet private var headerHeight: NSLayoutConstraint!
    @IBOutlet private var headerTop: NSLayoutConstraint!
    @IBOutlet private var headerRight: NSLayoutConstraint!
    @IBOutlet private var headerBottom: NSLayoutConstraint!
    @IBOutlet private var headerLeft: NSLayoutConstraint!

    @IBOutlet private var bodyStackView: UIStackView!
    @IBOutlet private var bodyHeight: NSLayoutConstraint!
    @IBOutlet private var bodyTop: NSLayoutConstraint!
    @IBOutlet private var bodyRight: NSLayoutConstraint!
    @IBOutlet private var bodyBottom: NSLayoutConstraint!
    @IBOutlet private var bodyLeft: NSLayoutConstraint!

    @IBOutlet private var footerStackView: UIStackView!
    @IBOutlet private var footerHeight: NSLayoutConstraint!
    @IBOutlet private var footerTop: NSLayoutConstraint!
    @IBOutlet private var footerRight: NSLayoutConstraint!
    @IBOutlet private var footerBottom: NSLayoutConstraint!
    @IBOutlet private var footerLeft: NSLayoutConstraint!

    // MARK: LayoutComponent

    public var driver: StackLayoutDriver! {
        didSet {
            self.title = driver.title
            children.forEach { $0.removeFromParent() }
            headerStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            bodyStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            footerStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

            headerHeight.isActive = driver.headerViewController.isEmpty
            driver.headerViewController.forEach { viewController in
                addChild(viewController)
                headerStackView.addArrangedSubview(viewController.view)
            }

            driver.bodyViewController.forEach { viewController in
                addChild(viewController)
                bodyStackView.addArrangedSubview(viewController.view)
            }

            footerHeight.isActive = driver.footerViewController.isEmpty
            driver.footerViewController.forEach { viewController in
                addChild(viewController)
                footerStackView.addArrangedSubview(viewController.view)
            }
        }
    }

    public var style = Style() {
        didSet {
            adjustContrainst()
        }
    }

    public static var storyboardName: String = "StackLayoutView"

    // MARK: Privates

    private func adjustContrainst() {
        bodyHeight.isActive = false

        headerTop.constant = style.headerMargins.top
        headerLeft.constant = style.headerMargins.left
        headerRight.constant = style.headerMargins.right
        headerBottom.constant = style.headerMargins.bottom

        bodyTop.constant = style.bodyMargins.top
        bodyLeft.constant = style.bodyMargins.left
        bodyRight.constant = style.bodyMargins.right
        bodyBottom.constant = style.bodyMargins.bottom

        // Disable the height is there are footers, let the stack determine its own size
        footerTop.constant = style.footerMargins.top
        footerLeft.constant = style.footerMargins.left
        footerRight.constant = style.footerMargins.right
        footerBottom.constant = style.footerMargins.bottom
    }
}
