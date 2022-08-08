//
//  InfomationView.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/07.
//

import UIKit

final class InfomationView: UIView {

    private var infomationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.text = "정보"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var infomationTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(InformationCell.self, forCellReuseIdentifier: InformationCell.reuseIdentifier)
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureLayouts()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(delegate: UITableViewDelegate, dataSource: UITableViewDataSource?) {
        infomationTableView.delegate = delegate
        infomationTableView.dataSource = dataSource
    }
    
    func reloadTableView() {
        infomationTableView.reloadData()
    }
}

private extension InfomationView {

    func configureLayouts() {
        addSubviews(infomationLabel, infomationTableView)
        
        NSLayoutConstraint.activate([
            infomationLabel.topAnchor.constraint(equalTo: topAnchor),
            infomationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            infomationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            infomationLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15)
        ])
        
        NSLayoutConstraint.activate([
            infomationTableView.topAnchor.constraint(equalTo: infomationLabel.bottomAnchor, constant: 5),
            infomationTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            infomationTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infomationTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
