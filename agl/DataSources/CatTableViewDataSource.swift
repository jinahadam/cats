//
//  CatTableViewDataSource.swift
//  agl
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import UIKit

class CatTableViewDataSource: NSObject, UITableViewDataSource {

    var data = CatData?
    var isLoading = false
    var completionBlock: (() -> Void)?

    func loadData() {
        isLoading = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}
