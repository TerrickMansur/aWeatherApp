//
//  CityListViewController.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit
import ReactiveKit

protocol CityListViewModelType {

    var contentDidUpdate: Signal<Void, Never> { get }
    var numberOfSection: Int { get }

    func numberOfRowsInSection(section: Int) -> Int
    func cellViewModelFor(indexPath: IndexPath) -> CityTableViewCellViewModelType
}

class CityListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, Componentable {

    // MARK: IBOutlet
    @IBOutlet var tableView: UITableView!

    // MARK: Componentable
    static var storyboard: String = "CityList"

    var viewModel: CityListViewModelType! {
        didSet {
            self.viewModel.contentDidUpdate.observeNext { [weak self] _ in
                self?.tableView.reloadData()
            }.dispose(in: self.bag)
        }
    }
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as? CityTableViewCell else {
            fatalError("Could not dequeue 'cityCell' from CityList tableview 😐")
        }
        
        cell.viewModel = viewModel.cellViewModelFor(indexPath: indexPath)
        
        return cell
    }
}
