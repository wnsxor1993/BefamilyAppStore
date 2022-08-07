//
//  ViewController.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {

    private var mainViewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    private var subDescriptionDatasource: CollectionViewDatasource<SubDescriptionEntity, SubDescriptionCell>?
    
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var titleView = MainTitleView()
    private var featureView = NewFeatureView()
    
    private lazy var subDescriptionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 3.3, height: view.frame.height * 0.15)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SubDescriptionCell.self, forCellWithReuseIdentifier: SubDescriptionCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private var contentViewHeightConstraint = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayouts()
        configureBinding()
        subDescriptionCollectionView.delegate = self
        mainViewModel.enquireMainPageData()
    }
}

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}

private extension MainViewController {
    
    func configureLayouts() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(titleView, subDescriptionCollectionView, featureView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        featureView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.16)
        ])
        
        NSLayoutConstraint.activate([
            subDescriptionCollectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            subDescriptionCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subDescriptionCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subDescriptionCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ])
        
        NSLayoutConstraint.activate([
            featureView.topAnchor.constraint(equalTo: subDescriptionCollectionView.bottomAnchor),
            featureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            featureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            featureView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
    
    func configureBinding() {
        let output = mainViewModel.transform(disposeBag: disposeBag)
        
        output.mainPageData
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { [weak self] entity in
                // TODO: 데이터소스나 뷰에 데이터 연결 하위 메서드 생성하고 여기서 불러주기
                guard let self = self else { return }
                self.subDescriptionDatasource = CollectionViewDatasource(entity.secondSection, reuseIdentifier: SubDescriptionCell.reuseIdentifier) { (data: SubDescriptionEntity, cell: SubDescriptionCell) in
                    cell.set(itemSection: data.index, entity: data)
                }
                self.subDescriptionCollectionView.dataSource = self.subDescriptionDatasource
                self.subDescriptionCollectionView.reloadData()
                
                self.featureView.set(with: entity.thirdSection)
                
                self.setContentViewHeight()
            }
            .disposed(by: disposeBag)
    }
    
    func setContentViewHeight() {
        NSLayoutConstraint.deactivate(contentViewHeightConstraint)

        let contentViewHeight = titleView.frame.height + subDescriptionCollectionView.frame.height + featureView.frame.height

        contentViewHeightConstraint = [contentView.heightAnchor.constraint(equalToConstant: contentViewHeight)]
        NSLayoutConstraint.activate(contentViewHeightConstraint)
    }
}
