//
//  NewFeatureView.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/07.
//

import UIKit
import RxSwift
import RxCocoa

final class NewFeatureView: UIView {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textColor = .black
        label.text = "새로운 기능"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var versionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("더 보기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureLayouts()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with entity: NewFeatureEntity) {
        versionLabel.text = "버전 \(entity.version)"
        dateLabel.text = entity.updatedDate
        descriptionLabel.text = entity.releaseNotes
    }
    
    func connectAction() -> Observable<Void> {
        return moreButton.rx.tap.asObservable()
    }
    
    func deleteButton() {
        descriptionLabel.numberOfLines = 0
        moreButton.removeFromSuperview()
    }
}

private extension NewFeatureView {
    
    func configureLayouts() {
        addSubviews(titleLabel, versionLabel, dateLabel, descriptionLabel, moreButton)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            versionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            versionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            versionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 25),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            moreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            moreButton.heightAnchor.constraint(equalToConstant: 25),
            moreButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.18)
        ])
    }
}
