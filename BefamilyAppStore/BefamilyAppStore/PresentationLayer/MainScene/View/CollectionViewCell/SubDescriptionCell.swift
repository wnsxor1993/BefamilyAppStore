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
        stack.distribution = .equalCentering
        stack.axis = .vertical
        
        return stack
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14, weight: .bold)
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
    
    private var extraLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayouts()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(itemSection: Int, entity: SecondSectionEntity) {
        guard let validCase = ItemCase.init(rawValue: itemSection) else { return }
        configureItem(with: validCase, entity: entity)
    }
}

private extension SubDescriptionCell {
    
    func configureLayouts() {
        contentView.addSubviews(stackView)
        stackView.addArrangedSubviews(titleLabel, contentLabel, extraLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configureItem(with validCase: ItemCase, entity: SecondSectionEntity) {
        switch validCase {
        case .firstItem:
            titleLabel.text = "\(entity.ratingCount)개의 평가"
            contentLabel.text = entity.averageRating
            configureRateStar(about: entity.averageRating)
            
        case .secondItem:
            titleLabel.text = "연령"
            contentLabel.text = entity.trackContentRating
            extraLabel.text = "세"
            
        case .thirdItem:
            titleLabel.text = "카테고리"
            extraLabel.text = entity.category
            configureImageToLabel(with: "bubble.left.and.bubble.right.fill")
            
        case .fourthItem:
            titleLabel.text = "개발자"
            extraLabel.text = entity.programmerName
            configureImageToLabel(with: "person.crop.circle")
        
        case .fifthItem:
            let aboutLanguage = configureLanguage(with: entity.languageCodesISO2A)
            
            titleLabel.text = "언어"
            contentLabel.text = aboutLanguage.0
            extraLabel.text = "\(aboutLanguage.1)개의 언어"
        }
    }
    
    func configureRateStar(about rate: String) {
        guard let validRate = Float(rate) else { return }
        let tenthDigit = Int(round(validRate * 10)) / 10
        
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttatchment = NSTextAttachment()
        
        for _ in 0 ..< tenthDigit {
            imageAttatchment.image = UIImage(systemName: "star.fill")
            attributedString.append(NSAttributedString(attachment: imageAttatchment))
        }
        
        if tenthDigit < 5 {
            imageAttatchment.image = UIImage(systemName: "star.leadinghalf.filled")
            attributedString.append(NSAttributedString(attachment: imageAttatchment))
            
            for _ in 0 ..< 4 - tenthDigit {
                imageAttatchment.image = UIImage(systemName: "star")
                attributedString.append(NSAttributedString(attachment: imageAttatchment))
            }
        }
        
        extraLabel.attributedText = attributedString
    }
    
    func configureImageToLabel(with systemName: String) {
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttatchment = NSTextAttachment()
        imageAttatchment.image = UIImage(systemName: systemName)
        attributedString.append(NSAttributedString(attachment: imageAttatchment))
        
        contentLabel.attributedText = attributedString
    }
    
    func configureLanguage(with languageCodes: [String]) -> (String, Int) {
        var languageCode = ""
        
        if let koIndex = languageCodes.firstIndex(of: "KO") {
            languageCode = languageCodes[koIndex]
            
        } else {
            languageCode = languageCodes[0]
        }
        
        return (languageCode, languageCodes.count - 1)
    }
}
