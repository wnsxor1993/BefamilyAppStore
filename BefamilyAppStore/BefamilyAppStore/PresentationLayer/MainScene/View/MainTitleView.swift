//
//  TitleView.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import UIKit

final class MainTitleView: UIView {
    
    private var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray
        label.numberOfLines = 1
        label.text = "가까운 사람들끼리 쓰는 메신저"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var downButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.setTitle("받기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayouts()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with entity: MainTitleEntity) {
        titleLabel.text = entity.appName
    }
    
    func set(with image: UIImage) {
        titleImageView.image = image
    }
}

private extension MainTitleView {
    
    func configureLayouts() {
        addSubviews(titleImageView, stackView, downButton)
        stackView.addArrangedSubviews(titleLabel, subLabel)
        
        NSLayoutConstraint.activate([
            titleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleImageView.topAnchor.constraint(equalTo: topAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleImageView.widthAnchor.constraint(equalTo: titleImageView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            downButton.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 15),
            downButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            downButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4),
            downButton.heightAnchor.constraint(equalTo: downButton.widthAnchor, multiplier: 0.35)
        ])
    }
}
