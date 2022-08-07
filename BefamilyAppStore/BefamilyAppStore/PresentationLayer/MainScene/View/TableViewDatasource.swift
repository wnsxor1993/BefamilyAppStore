//
//  TableViewDatasource.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/07.
//

import UIKit

final class TableViewDatasource<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource {

    typealias CellConfigurator = (Model, Cell) -> Void

    private var models: [Model]?
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(_ models: [Model]?, reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let models = models else { return 0 }

        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? Cell, let models = models else { return UITableViewCell() }
        
        cellConfigurator(models[indexPath.row], cell)
        return cell
    }
}
