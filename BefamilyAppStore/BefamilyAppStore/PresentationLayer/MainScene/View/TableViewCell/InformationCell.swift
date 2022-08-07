//
//  InformationCell.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/07.
//

import UIKit

class InformationCell: UITableViewCell {
    
    static let reuseIdentifier = "InformationCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayouts()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with itemSection: InfomationEntity) {
        titleLabel.text = itemSection.title
        contentLabel.text = itemSection.content
    }
}

private extension InformationCell {
    
    func configureLayouts() {
        contentView.addSubviews(titleLabel, contentLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
