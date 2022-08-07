//
//  DescriptionView.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/07.
//

import UIKit

final class DescriptionView: UIView {

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 3
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
    
    private var boxView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var programmerName: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var programmerLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        label.text = "개발자"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var buttonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
    
    func set(with entity: DescriptionEntity) {
        descriptionLabel.text = entity.description
        programmerName.text = entity.programmerName
    }
}

private extension DescriptionView {
    
    func configureLayouts() {
        addSubviews(descriptionLabel, moreButton, boxView)
        boxView.addSubviews(programmerName, programmerLabel, buttonImage)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: boxView.topAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            moreButton.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -13),
            moreButton.heightAnchor.constraint(equalToConstant: 25),
            moreButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.18)
        ])
        
        NSLayoutConstraint.activate([
            boxView.bottomAnchor.constraint(equalTo: bottomAnchor),
            boxView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            boxView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            boxView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            programmerName.topAnchor.constraint(equalTo: boxView.topAnchor),
            programmerName.leadingAnchor.constraint(equalTo: boxView.leadingAnchor),
            programmerName.heightAnchor.constraint(equalTo: boxView.heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            programmerLabel.topAnchor.constraint(equalTo: programmerName.bottomAnchor),
            programmerLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor),
            programmerLabel.heightAnchor.constraint(equalTo: boxView.heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            buttonImage.centerYAnchor.constraint(equalTo: boxView.centerYAnchor),
            buttonImage.trailingAnchor.constraint(equalTo: boxView.trailingAnchor),
            buttonImage.heightAnchor.constraint(equalTo: boxView.heightAnchor, multiplier: 0.5)
        ])
    }
}

