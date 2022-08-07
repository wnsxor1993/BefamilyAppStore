//
//  CollectionViewDatasource.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/07.
//

import UIKit

final class CollectionViewDatasource<Model, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {

    typealias CellConfigurator = (Model, Cell) -> Void

    private var models: [Model]?
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(_ models: [Model]?, reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let models = models else { return 0 }

        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? Cell, let models = models else { return UICollectionViewCell() }

        cellConfigurator(models[indexPath.row], cell)
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
