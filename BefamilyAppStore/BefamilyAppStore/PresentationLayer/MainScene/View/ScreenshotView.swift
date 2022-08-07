//
//  ScreenshotView.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/07.
//

import UIKit

final class ScreenshotView: UIView {

    private var screenshotLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.addBorder([.top], color: .gray, width: 0.5)
        label.textColor = .black
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.text = "미리보기"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private(set) lazy var screenshotCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
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
    
    func set(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource?) {
        screenshotCollectionView.delegate = delegate
        screenshotCollectionView.dataSource = dataSource
    }
    
    func reloadCollectionView() {
        screenshotCollectionView.reloadData()
    }
    
    func calculateItemSize() {
        let layout = UICollectionViewFlowLayout()
        let height = frame.height * 0.85
        layout.itemSize = CGSize(width: height * 0.56, height: height)
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        
        screenshotCollectionView.collectionViewLayout = layout
    }
}

private extension ScreenshotView {
    
    func configureLayouts() {
        addSubviews(screenshotLabel, screenshotCollectionView)
        
        NSLayoutConstraint.activate([
            screenshotLabel.topAnchor.constraint(equalTo: topAnchor),
            screenshotLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            screenshotLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            screenshotLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15)
        ])
        
        NSLayoutConstraint.activate([
            screenshotCollectionView.topAnchor.constraint(equalTo: screenshotLabel.bottomAnchor),
            screenshotCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            screenshotCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            screenshotCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85)
        ])
    }
}
