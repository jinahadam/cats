//
//  CatTableViewDataSource.swift
//  agl
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import UIKit

class CatTableViewDataSource: NSObject, UITableViewDataSource {

    private let client = AGLClient(session: URLSession.shared)
    private var data: CatData?
    var completion: (() -> Void)?

    private var sectionCount: Int {
        return 2
    }

    func loadData() {
        client.fetchList { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let people):
                self.data = CatData(responseModel: people)
                self.completion?()
            case .failure(let error):
                print(error)//show error
                self.completion?()
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ?  "Male" : "Female"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        return section == 0 ?  data.catsWithMaleOwners.count : data.catsWithFemaleOwners.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath)
        guard let data = data else { return cell }

        let cat = indexPath.section == 0 ? data.catsWithMaleOwners[indexPath.row] : data.catsWithFemaleOwners[indexPath.row]
        cell.textLabel?.text = cat.name
        return cell
    }
}
