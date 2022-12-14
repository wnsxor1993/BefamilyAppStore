//
//  MainViewModel.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation
import RxSwift
import RxRelay

final class MainViewModel {
    
    private(set) var mainPageEntity: MainPageEntity?
    
    private var mainUsecase: ViewMainPageUsecase
    
    struct Input {
        let titleDownButtonDidTapEvent: Observable<Void>
        let programmerLinkButtonDidTapEvent: Observable<UITapGestureRecognizer>
    }
    
    struct Output {
        let mainPageData = PublishRelay<MainPageEntity>()
        let naviImage = PublishRelay<UIImage>()
        let mainImage = PublishRelay<UIImage>()
        let screenshots = PublishRelay<[UIImage]>()
        
        let downloadURL = PublishRelay<URL>()
        let developerURL = PublishRelay<URL>()
    }
    
    init(main: ViewMainPageUsecase) {
        self.mainUsecase = main
    }
    
    convenience init() {
        self.init(main: ViewDefaultMainPageUsecase())
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.titleDownButtonDidTapEvent
            .subscribe { [weak self] _ in
                guard let validURL = self?.mainPageEntity?.mainTitle.downloadURL else { return }
                output.downloadURL.accept(validURL)
            }
            .disposed(by: disposeBag)
        
        input.programmerLinkButtonDidTapEvent
            .subscribe { [weak self] _ in
                guard let validURL = self?.mainPageEntity?.description.programmerViewURL else { return }
                output.developerURL.accept(validURL)
            }
            .disposed(by: disposeBag)
        
        mainUsecase.mainPageEntitySubject
            .subscribe { [weak self] pageEntity in
                guard let self = self else {
                    return
                }
                
                self.mainPageEntity = pageEntity
                output.mainPageData.accept(pageEntity)
            
            } onError: { [weak self] _ in
                self?.mainUsecase = ViewDefaultMainPageUsecase()
                self?.mainUsecase.executeMainData()
            }
            .disposed(by: disposeBag)
        
        mainUsecase.naviTitleImageSubject
            .subscribe { image in
                output.naviImage.accept(image)
            }
            .disposed(by: disposeBag)
        
        mainUsecase.mainImageSubject
            .subscribe { image in
                output.mainImage.accept(image)
            }
            .disposed(by: disposeBag)
        
        mainUsecase.screenshotsSubject
            .subscribe { images in
                output.screenshots.accept(images)
                
            }
            .disposed(by: disposeBag)

        return output
    }
    
    func enquireMainPageData() {
        mainUsecase.executeMainData()
    }
    
    func enquireNaviTitleImage(with url: URL?) {
        mainUsecase.executeNaviTitleImage(with: url)
    }
    
    func enquireMainTitleImage(with url: URL?) {
        mainUsecase.executeMainTitleImage(with: url)
    }
    
    func enquireScreenShotImages(with entities: [ScreenshotEntity]) {
        mainUsecase.executeScreenshots(with: entities)
    }
}
