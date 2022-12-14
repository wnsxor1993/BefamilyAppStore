//
//  ViewDefaultMainPageUsecase.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import UIKit
import RxSwift

final class ViewDefaultMainPageUsecase: ViewMainPageUsecase {
    
    private var mainRepository: ViewMainPageRepository
    let mainPageEntitySubject = PublishSubject<MainPageEntity>()
    let naviTitleImageSubject = PublishSubject<UIImage>()
    let mainImageSubject = PublishSubject<UIImage>()
    let screenshotsSubject = PublishSubject<[UIImage]>()
    
    let disposeBag = DisposeBag()
    
    init(mainRepo: ViewMainPageRepository) {
        self.mainRepository = mainRepo
    }
    
    convenience init() {
        self.init(mainRepo: ViewDefaultMainPageRepository())
    }
    
    func executeMainData() {
        mainRepository.fetchDTO()
            .subscribe { [weak self] mainDTO in
                guard let self = self else {
                    self?.mainPageEntitySubject.onError(ExtraError.rxGuardSelf)
                    return
                }
                
                let entity = self.alterToEntity(from: mainDTO)
                self.mainPageEntitySubject.onNext(entity)
                
            } onError: { [weak self] _ in
                self?.mainPageEntitySubject.onError(DataError.entityConvertingError)
            }
            .disposed(by: disposeBag)
    }
    
    func executeNaviTitleImage(with url: URL?) {
        mainRepository.searchImage(with: url)
            .subscribe { [weak self] image in
                self?.naviTitleImageSubject.onNext(image)
            
            } onError: { [weak self] _ in
                self?.naviTitleImageSubject.onError(DataError.entityConvertingError)
            }
            .disposed(by: disposeBag)
    }
    
    func executeMainTitleImage(with url: URL?) {
        mainRepository.searchImage(with: url)
            .subscribe { [weak self] image in
                self?.mainImageSubject.onNext(image)
            
            } onError: { [weak self] _ in
                self?.mainImageSubject.onError(DataError.entityConvertingError)
            }
            .disposed(by: disposeBag)
    }
    
    func executeScreenshots(with entities: [ScreenshotEntity]) {
        mainRepository.searchImagesArray(with: entities)
            .subscribe { [weak self] images in
                self?.screenshotsSubject.onNext(images)
                
            } onError: { [weak self] _ in
                self?.screenshotsSubject.onError(DataError.entityConvertingError)
            }
            .disposed(by: disposeBag)
    }
}

private extension ViewDefaultMainPageUsecase {
    
    func alterToEntity(from dto: MainPageDTO) -> MainPageEntity {
        
        return MainPageEntity(naviTitle: alterToNaviEntity(from: dto), mainTitle: alterToMainTitleEntity(from: dto), subDescription: alterToSubDescriptionEntity(from: dto), newFeature: alterToNewFeatureEntity(from: dto), screenshot: alterToScreenshotEntity(from: dto), description: alterToDescriptionEntity(from: dto), infomation: alterToInfomationEntity(from: dto))
    }
}

// MARK: ?????? Entity ?????? ????????? ??????

private extension ViewDefaultMainPageUsecase {
    
    func alterToNaviEntity(from dto: MainPageDTO) -> NavigationTitleEntity {
        let naviTitleImageURL = changeToURL(with: dto.artworkUrl60)
        
        return NavigationTitleEntity(navigationTitleImageURL: naviTitleImageURL, downloadURL: changeToURL(with: dto.trackViewURL))
    }
    
    func alterToMainTitleEntity(from dto: MainPageDTO) -> MainTitleEntity {
        let appIconImageURL = changeToURL(with: dto.artworkUrl512)
        
        return MainTitleEntity(appIconImageURL: appIconImageURL, appName: dto.trackName, downloadURL: changeToURL(with: dto.trackViewURL))
    }
    
    func alterToSubDescriptionEntity(from dto: MainPageDTO) -> [SubDescriptionEntity] {
        var entities = [SubDescriptionEntity]()
        var category = ""
        
        if let koIndex = dto.languageCodesISO2A.firstIndex(of: "KO") {
            category = dto.languageCodesISO2A[koIndex]
        } else {
            category = dto.languageCodesISO2A[0]
        }
        
        SubDescriptionSection.allCases.forEach {
            switch $0 {
            case .firstItem:
                let temp = SubDescriptionEntity(index: $0.rawValue, title: "\(dto.userRatingCountForCurrentVersion)?????? ??????", content: "\(round(dto.averageUserRating * 10) / 10)", extra: "???????????????")
                entities.append(temp)
                
            case .secondItem:
                let temp = SubDescriptionEntity(index: $0.rawValue, title: "??????", content: dto.trackContentRating, extra: "???")
                entities.append(temp)
                
            case .thirdItem:
                let temp = SubDescriptionEntity(index: $0.rawValue, title: "????????????", content: "bubble.left.and.bubble.right.fill", extra: dto.genres[0])
                entities.append(temp)
                
            case .fourthItem:
                let temp = SubDescriptionEntity(index: $0.rawValue, title: "?????????", content: "person.crop.circle", extra: dto.artistName)
                entities.append(temp)
                
            case .fifthItem:
                let temp = SubDescriptionEntity(index: $0.rawValue, title: "??????", content: category, extra: "+ \(dto.languageCodesISO2A.count - 1)?????? ??????")
                entities.append(temp)
            }
        }
        
        return entities
    }
    
    func alterToNewFeatureEntity(from dto: MainPageDTO) -> NewFeatureEntity {
        
        return NewFeatureEntity(version: dto.version, releaseNotes: dto.releaseNotes, updatedDate: DateConverter.calculateToday(from: dto.currentVersionReleaseDate))
    }
    
    func alterToScreenshotEntity(from dto: MainPageDTO) -> [ScreenshotEntity] {
        var entities = [ScreenshotEntity]()
        
        dto.screenshotUrls.forEach {
            guard let url = changeToURL(with: $0) else { return }
            let temp = ScreenshotEntity(validURL: url)
            entities.append(temp)
        }
        
        return entities
    }
    
    func alterToDescriptionEntity(from dto: MainPageDTO) -> DescriptionEntity {
        
        return DescriptionEntity(description: dto.description, programmerName: dto.artistName, programmerViewURL: changeToURL(with: dto.artistViewURL))
    }
    
    func alterToInfomationEntity(from dto: MainPageDTO) -> [InfomationEntity] {
        var entities = [InfomationEntity]()
        
        InfomationSection.allCases.forEach {
            switch $0 {
            case .firstItem:
                let temp = InfomationEntity(title: "?????????", content: dto.sellerName)
                entities.append(temp)
                
            case .secondItem:
                let temp = InfomationEntity(title: "??????", content: "\(calculateMegaByte(from: dto.fileSizeBytes))MB")
                entities.append(temp)
                
            case .thirdItem:
                let temp = InfomationEntity(title: "????????????", content: dto.genres[0])
                entities.append(temp)
                
            case .fourthItem:
                let temp = InfomationEntity(title: "?????????", content: "iSO \(dto.minimumOSVersion)")
                entities.append(temp)
                
            case .fifthItem:
                let temp = InfomationEntity(title: "??????", content: convertToString(from: dto.languageCodesISO2A))
                entities.append(temp)
                
            case .sixthItem:
                let temp = InfomationEntity(title: "?????? ??????", content: dto.trackContentRating)
                entities.append(temp)
                
            case .seventhItem:
                let temp = InfomationEntity(title: "?????????", content: "?? \(DateConverter.calculateYear(from: dto.releaseDate)) \(dto.sellerName)")
                entities.append(temp)
            }
        }
        
        return entities
    }
}

// MARK: ????????? ?????? ?????? ????????? ??????

private extension ViewDefaultMainPageUsecase {
    
    func changeToURL(with string: String) -> URL? {
        return URL(string: string)
    }
    
    func calculateMegaByte(from byte: String) -> String {
        guard let realByte = Float(byte) else { return "" }
        
        let value = round((realByte / 1024000) * 10) / 10
        
        return "\(value)"
    }
    
    func convertToString(from iso: [String]) -> String {
        let isoDictionary = ["KO": "?????????", "EN": "??????"]
        var tempStrings = [String]()
        
        iso.forEach {
            guard let value = isoDictionary[$0] else { return }
            tempStrings.append(value)
        }
        
        return tempStrings.reduce("") { (result: String, next: String) -> String in
            if result.isEmpty {
                return "\(next)"
            } else {
                return "\(result), \(next)"
            }
        }
    }
}
