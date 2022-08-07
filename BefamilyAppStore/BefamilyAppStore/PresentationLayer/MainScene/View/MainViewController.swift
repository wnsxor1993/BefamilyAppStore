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
    private var navigationImageView = UIImageView()
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
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SubDescriptionCell.self, forCellWithReuseIdentifier: SubDescriptionCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private var contentViewHeightConstraint = [NSLayoutConstraint]()
    private var featureViewHeightConstraint = [NSLayoutConstraint]()
    
    private var contentViewHeight: CGFloat {
        titleView.frame.height + subDescriptionCollectionView.frame.height + featureView.frame.height + screenView.frame.height + descriptionView.frame.height + infomationView.frame.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        configureLayouts()
        configureBinding()
        configureInnerAction()
        mainViewModel.enquireMainPageData()
        scrollView.delegate = self
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
            self.navigationItem.titleView = navigationImageView
        } else {
            self.navigationItem.titleView = nil
        }
    }
}


// MARK: Layout Setting
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
            featureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        featureViewHeightConstraint = [featureView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)]
        NSLayoutConstraint.activate(featureViewHeightConstraint)
        
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
    
    func setContentViewHeight() {
        NSLayoutConstraint.deactivate(contentViewHeightConstraint)

        contentViewHeightConstraint = [contentView.heightAnchor.constraint(equalToConstant: contentViewHeight)]
        NSLayoutConstraint.activate(contentViewHeightConstraint)
        
        titleView.layer.addBorder([.bottom], color: .gray, width: 0.5)
    }
    
    func replaceFeatureViewHeight() {
        NSLayoutConstraint.deactivate(featureViewHeightConstraint)
        
        featureViewHeightConstraint = [featureView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)]
        NSLayoutConstraint.activate(featureViewHeightConstraint)
    }
}


// MARK: Binding Setting
private extension MainViewController {
    
    func configureBinding() {
        let output = mainViewModel.transform(input: MainViewModel.Input(titleDownButtonDidTapEvent: titleView.connectAction()), disposeBag: disposeBag)
        
        output.mainPageData
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { [weak self] entity in
                guard let self = self else { return }
                self.mainViewModel.enquireNaviTitleImage(with: entity.naviTitle.navigationTitleImageURL)
                
                self.titleView.set(with: entity.mainTitle)
                self.mainViewModel.enquireMainTitleImage(with: entity.mainTitle.appIconImageURL)
                self.featureView.set(with: entity.newFeature)
                self.descriptionView.set(with: entity.description)
                
                self.setDatasourceWhen(receive: entity)
                self.mainViewModel.enquireScreenShotImages(with: entity.screenshot)
            }
            .disposed(by: disposeBag)
        
        output.naviImage
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { [weak self] image in
                guard let self = self else { return }
                self.navigationImageView.image = image
                self.navigationImageView.contentMode = .scaleAspectFit
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
                self.setDatasourceWhen(receive: images)
                
                UIView.animate(withDuration: 0) {
                    self.setContentViewHeight()
                    self.view.layoutIfNeeded()
                }
            }
            .disposed(by: disposeBag)
        
        output.downloadURL
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { url in
                print(url)
                UIApplication.shared.open(url)
            }
            .disposed(by: disposeBag)
    }
    
    func configureInnerAction() {
        featureView.connectAction()
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { [weak self] _ in
                UIView.animate(withDuration: 0.5) {
                    self?.replaceFeatureViewHeight()
                    self?.view.layoutIfNeeded()
                }
                
                self?.featureView.deleteButton()
                self?.setContentViewHeight()
            }
            .disposed(by: disposeBag)
    }
}


// MARK: Collection/TableView datasource setting with reload
private extension MainViewController {

    func setDatasourceWhen(receive entity: MainPageEntity) {
        subDescriptionDatasource = CollectionViewDatasource(entity.subDescription, reuseIdentifier: SubDescriptionCell.reuseIdentifier) { (data: SubDescriptionEntity, cell: SubDescriptionCell) in
            cell.set(itemSection: data.index, entity: data)
        }
        subDescriptionCollectionView.dataSource = subDescriptionDatasource
        subDescriptionCollectionView.reloadData()
        
        infomationDatasource = TableViewDatasource(entity.infomation, reuseIdentifier: InformationCell.reuseIdentifier) { (data: InfomationEntity, cell: InformationCell) in
            cell.set(with: data)
        }
        infomationView.set(delegate: self, dataSource: self.infomationDatasource)
        infomationView.reloadTableView()
    }
    
    func setDatasourceWhen(receive screenshots: [UIImage]) {
        screenshotDatasource = CollectionViewDatasource(screenshots, reuseIdentifier: ScreenshotCell.reuseIdentifier) { (image: UIImage, cell: ScreenshotCell) in
            cell.set(image: image)
        }
        screenView.calculateItemSize()
        screenView.set(delegate: self, dataSource: screenshotDatasource)
        screenView.reloadCollectionView()
    }
}
