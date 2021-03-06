//
//  ViewController.swift
//  agl
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let tableViewDataSource = CatTableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tableViewDataSource
        title = "AGL Cats"

        tableViewDataSource.completion = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        tableViewDataSource.loadData()
    }


}

