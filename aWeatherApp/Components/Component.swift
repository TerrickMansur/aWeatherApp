//
//  Component.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit

enum Component {
    enum Factory {}
}

protocol Componentable {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    static var storyboard: String { get }
}

extension Componentable {
    
    static func create<GenericVC: Componentable>(viewModelProvider: (_ GenericVC: GenericVC) ->
        (GenericVC.ViewModelType)) -> GenericVC where GenericVC : UIViewController {
        
        guard var component = (UIStoryboard.init(
            name: self.storyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: self.storyboard) as? GenericVC) else {
                fatalError("Could not create component") }
        
        component.loadViewIfNeeded()
        component.viewModel = viewModelProvider(component)
        
        return component
    }
}
