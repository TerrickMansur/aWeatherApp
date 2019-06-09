//
//  UIView+Find.swift
//  aWeatherAppTests
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit

internal extension UIView {
    
    func findSubView(restorationIdentifier: String) -> UIView? {
        for view in subviews {
            if view.restorationIdentifier == restorationIdentifier {
                return view
            }
            else {
                if let subview = view.findSubView(restorationIdentifier: restorationIdentifier) {
                    return subview
                }
            }
        }
        return nil
    }
    
    func asButton() -> UIButton? {
        return self as? UIButton
    }
    
    func asLabel() -> UILabel? {
        return self as? UILabel
    }
    
    func asTableView() -> UITableView? {
        return self as? UITableView
    }
    
    func asImageView() -> UIImageView? {
        return self as? UIImageView
    }
    
    func asActivityIndicatorView() -> UIActivityIndicatorView? {
        return self as? UIActivityIndicatorView
    }

}
