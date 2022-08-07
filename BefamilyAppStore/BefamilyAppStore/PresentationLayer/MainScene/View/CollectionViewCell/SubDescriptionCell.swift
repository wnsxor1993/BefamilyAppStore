//
//  SubDescriptionCell.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/07.
//

import UIKit

final class SubDescriptionCell: UICollectionViewCell {

    enum ItemCase: Int {
        case firstItem = 0
        case secondItem
        case thirdItem
        case fourthItem
        case fifthItem
    }
    
    static let reuseIdentifier = "SubDescriptionCell"
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var contentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .gray
        imageView.sizeToFit()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var extraLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
//        configureLayouts()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(itemSection: Int, entity: SecondSectionEntity) {
        guard let validCase = ItemCase.init(rawValue: itemSection) else { return }
        configureLayouts(with: validCase)
        configureItem(with: validCase, entity: entity)
    }
}

private extension SubDescriptionCell {
    
    func configureLayouts(with validCase: ItemCase) {
        switch validCase {
        case .firstItem, .secondItem, .fifthItem:
            contentView.addSubviews(stackView)
            stackView.addArrangedSubviews(titleLabel, contentLabel, extraLabel)
            
        case .thirdItem, .fourthItem:
            contentView.addSubviews(stackView)
            stackView.addArrangedSubviews(titleLabel, contentImage, extraLabel)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configureItem(with validCase: ItemCase, entity: SecondSectionEntity) {
        switch validCase {
        case .firstItem, .secondItem, .fifthItem:
            titleLabel.text = entity.title
            contentLabel.text = entity.content
            extraLabel.text = entity.extra
            
        case .thirdItem, .fourthItem:
            titleLabel.text = entity.title
            contentImage.image = UIImage(systemName: entity.content)
            extraLabel.text = entity.extra
        }
    }
    
    func configureImageToLabel(with systemName: String) {
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttatchment = NSTextAttachment()
        imageAttatchment.image = UIImage(systemName: systemName)
        attributedString.append(NSAttributedString(attachment: imageAttatchment))
        
        contentLabel.attributedText = attributedString
    }
}
