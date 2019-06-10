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

    var title: String { get }
    
    var contentDidUpdate: SafeSignal<Void> { get }
    var numberOfSection: Int { get }
    
    func titleForSection(section: Int) -> String
    func numberOfRowsInSection(section: Int) -> Int
    func cellViewModelFor(indexPath: IndexPath) -> CityTableViewCellViewModelType
}

class CityListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, Componentable {

    struct Output {
        let didSelectIndexPath: SafeSignal<IndexPath>
    }

    var output: Output {
        return Output(didSelectIndexPath: self.tableView.reactive.selectedRowIndexPath)
    }
    
    // MARK: IBOutlet
    @IBOutlet var tableView: UITableView!

    // MARK: Componentable
    static var storyboard: String = "CityList"

    var viewModel: CityListViewModelType! {
        didSet {
            self.title = self.viewModel.title
            self.viewModel.contentDidUpdate.observeNext { [weak self] _ in
                self?.tableView.reloadData()
            }.dispose(in: self.bag)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reactive.selectedRowIndexPath.observeNext { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }.dispose(in: self.bag)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(section: section)
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
