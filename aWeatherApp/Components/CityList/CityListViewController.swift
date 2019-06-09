//
//  CityListViewController.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import UIKit

protocol CityListViewModelType {
    var numberOfRowsInSection: Int { get }
    var numberOfSection: Int { get }
}

class CityListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, Componentable {

    // MARK: IBOutlet
    @IBOutlet var tableView: UITableView!

    // MARK: Componentable
    static var storyboard: String = "CityList"

    var viewModel: CityListViewModelType! {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as? CityTableViewCell else {
            fatalError("Could not dequeue 'cityCell' from CityList tableview 😐")
        }
        
        return cell
    }
}
