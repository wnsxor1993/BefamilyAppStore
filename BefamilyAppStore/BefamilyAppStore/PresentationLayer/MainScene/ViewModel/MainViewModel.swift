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
    
    struct Output {
        let mainPageData = PublishRelay<MainPageEntity>()
        let mainImage = PublishRelay<UIImage>()
        let screenshots = PublishRelay<[UIImage]>()
    }
    
    init(main: ViewMainPageUsecase) {
        self.mainUsecase = main
    }
    
    convenience init() {
        self.init(main: ViewDefaultMainPageUsecase())
    }
    
    func transform(disposeBag: DisposeBag) -> Output {
        let output = Output()
        
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
        
        mainUsecase.imageSubject
            .subscribe { image in
                output.mainImage.accept(image)
            }
            .disposed(by: disposeBag)
        
        mainUsecase.imagesArraySubject
            .subscribe { images in
                output.screenshots.accept(images)
                
            }
            .disposed(by: disposeBag)

        return output
    }
    
    func enquireMainPageData() {
        mainUsecase.executeMainData()
    }
    
    func enquireMainTitleImage(with url: URL?) {
        mainUsecase.executeMainTitleImage(with: url)
    }
    
    func enquireScreenShotImages(with entities: [ScreenshotEntity]) {
        mainUsecase.executeScreenshots(with: entities)
    }
}
