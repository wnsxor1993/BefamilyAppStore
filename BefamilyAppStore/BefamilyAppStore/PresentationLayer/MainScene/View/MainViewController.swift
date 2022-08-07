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
    private var screenshotDatasource: CollectionViewDatasource<UIImage, ScreenshotCell>?
    private var infomationDatasource: TableViewDatasource<InfomationEntity, InformationCell>?
    
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var titleView = MainTitleView()
    private var featureView = NewFeatureView()
    private var screenView = ScreenshotView()
    private var descriptionView = DescriptionView()
    private var infomationView = InfomationView()
    
    private lazy var subDescriptionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 3.3, height: view.frame.height * 0.15)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.borderWidth = 0.5
        collectionView.layer.borderColor = UIColor.gray.cgColor
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SubDescriptionCell.self, forCellWithReuseIdentifier: SubDescriptionCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private var contentViewHeightConstraint = [NSLayoutConstraint]()
    private var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayouts()
        configureBinding()
        mainViewModel.enquireMainPageData()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.scrollView.delegate = self
    }
}

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension MainViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            self.navigationController?.navigationBar.isHidden = false
        } else {
            self.navigationController?.navigationBar.isHidden = true
        }
    }
}

private extension MainViewController {
    
    func configureLayouts() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(titleView, subDescriptionCollectionView, featureView, screenView, descriptionView, infomationView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        featureView.translatesAutoresizingMaskIntoConstraints = false
        screenView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        infomationView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        NSLayoutConstraint.activate([
            screenView.topAnchor.constraint(equalTo: featureView.bottomAnchor),
            screenView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screenView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screenView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
        
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: screenView.bottomAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            infomationView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor),
            infomationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infomationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infomationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    func configureBinding() {
        let output = mainViewModel.transform(disposeBag: disposeBag)
        
        output.mainPageData
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { [weak self] entity in
                guard let self = self else { return }
                self.mainViewModel.enquireNaviTitleImage(with: entity.naviTitle.navigationTitleImageURL)
                
                self.titleView.set(with: entity.mainTitle)
                self.mainViewModel.enquireMainTitleImage(with: entity.mainTitle.appIconImageURL)
                
                self.subDescriptionDatasource = CollectionViewDatasource(entity.subDescription, reuseIdentifier: SubDescriptionCell.reuseIdentifier) { (data: SubDescriptionEntity, cell: SubDescriptionCell) in
                    cell.set(itemSection: data.index, entity: data)
                }
                self.subDescriptionCollectionView.dataSource = self.subDescriptionDatasource
                self.subDescriptionCollectionView.reloadData()
                
                self.infomationDatasource = TableViewDatasource(entity.infomation, reuseIdentifier: InformationCell.reuseIdentifier) { (data: InfomationEntity, cell: InformationCell) in
                    cell.set(with: data)
                }
                self.infomationView.set(delegate: self, dataSource: self.infomationDatasource)
                self.infomationView.reloadTableView()
                
                self.featureView.set(with: entity.newFeature)
                self.descriptionView.set(with: entity.description)
                
                self.mainViewModel.enquireScreenShotImages(with: entity.screenshot)
            }
            .disposed(by: disposeBag)
        
        output.naviImage
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { [weak self] image in
                guard let self = self else { return }
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                
                self.navigationItem.titleView = imageView
            }
            .disposed(by: disposeBag)
        
        output.mainImage
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { [weak self] image in
                guard let self = self else { return }
                self.titleView.set(with: image)
            }
            .disposed(by: disposeBag)
        
        output.screenshots
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { [weak self] images in
                guard let self = self else { return }
                self.screenshotDatasource = CollectionViewDatasource(images, reuseIdentifier: ScreenshotCell.reuseIdentifier) { (image: UIImage, cell: ScreenshotCell) in
                    cell.set(image: image)
                }
                self.screenView.calculateItemSize()
                self.screenView.set(delegate: self, dataSource: self.screenshotDatasource)
                self.screenView.reloadCollectionView()
                
                self.setContentViewHeight()
            }
            .disposed(by: disposeBag)
    }
    
    func setContentViewHeight() {
        NSLayoutConstraint.deactivate(contentViewHeightConstraint)

        let contentViewHeight = titleView.frame.height + subDescriptionCollectionView.frame.height + featureView.frame.height + screenView.frame.height + descriptionView.frame.height + infomationView.frame.height

        contentViewHeightConstraint = [contentView.heightAnchor.constraint(equalToConstant: contentViewHeight)]
        NSLayoutConstraint.activate(contentViewHeightConstraint)
        
        featureView.layer.addBorder([.bottom], color: .gray, width: 0.5)
        screenView.layer.addBorder([.bottom], color: .gray, width: 0.5)
        descriptionView.layer.addBorder([.bottom], color: .gray, width: 0.5)
    }
}
