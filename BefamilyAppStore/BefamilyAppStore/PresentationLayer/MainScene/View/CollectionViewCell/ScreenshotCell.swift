//
//  ScreenshotCell.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/07.
//

import UIKit

final class ScreenshotCell: UICollectionViewCell {

    static let reuseIdentifier = "ScreenshotCell"
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayouts()
        contentView.backgroundColor = .white
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage) {
        imageView.image = image
    }
}

private extension ScreenshotCell {
    
    func configureLayouts() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
