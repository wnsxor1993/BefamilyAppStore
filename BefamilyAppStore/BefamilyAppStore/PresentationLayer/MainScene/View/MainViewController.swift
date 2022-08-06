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
    
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var titleView = MainTitleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayouts()
    }
}

private extension MainViewController {
    
    func configureLayouts() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(titleView)
        
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
            titleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18)
        ])
        
        
    }
    
    func configureBinding() {
        let output = mainViewModel.transform(disposeBag: disposeBag)
        
        output.mainPageData
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { [weak self] entity in
                // TODO: 데이터소스나 뷰에 데이터 연결 하위 메서드 생성하고 여기서 불러주기
                
            }
            .disposed(by: disposeBag)
    }
}
