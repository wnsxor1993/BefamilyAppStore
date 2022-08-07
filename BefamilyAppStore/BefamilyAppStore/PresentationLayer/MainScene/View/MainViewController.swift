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
    
    private var subDescriptionDatasource: CollectionViewDatasource<SecondSectionEntity, SubDescriptionCell>?
    
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var titleView = MainTitleView()
    
    private lazy var subDescriptionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .black
        collectionView.register(SubDescriptionCell.self, forCellWithReuseIdentifier: SubDescriptionCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayouts()
        configureBinding()
        mainViewModel.enquireMainPageData()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3.3
        return CGSize(width: width, height: subDescriptionCollectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

private extension MainViewController {
    
    func configureLayouts() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(titleView, subDescriptionCollectionView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
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
    }
    
    func configureBinding() {
        let output = mainViewModel.transform(disposeBag: disposeBag)
        
        output.mainPageData
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { [weak self] entity in
                // TODO: 데이터소스나 뷰에 데이터 연결 하위 메서드 생성하고 여기서 불러주기
                guard let self = self else { return }
                self.subDescriptionDatasource = CollectionViewDatasource(entity.secondSection, reuseIdentifier: SubDescriptionCell.reuseIdentifier) { (data: SecondSectionEntity, cell: SubDescriptionCell) in
                    cell.set(itemSection: data.index, entity: data)
                }
                self.subDescriptionCollectionView.dataSource = self.subDescriptionDatasource
                self.subDescriptionCollectionView.reloadData()
            }
            .disposed(by: disposeBag)
    }
}
