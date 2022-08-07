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
    let screenshotImagesSubject = PublishSubject<[UIImage]>()
    
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
                
            } onCompleted: {
                self.mainPageEntitySubject.onCompleted()
                
            }
            .disposed(by: disposeBag)
    }
    
    func executeScreenshots(with entities: [ScreenshotEntity]) {
        mainRepository.searchImages(with: entities)
            .subscribe { [weak self] images in
                self?.screenshotImagesSubject.onNext(images)
                
            } onError: { [weak self] _ in
                self?.screenshotImagesSubject.onError(DataError.entityConvertingError)
            }
            .disposed(by: disposeBag)
    }
}

private extension ViewDefaultMainPageUsecase {
    
    func alterToEntity(from dto: MainPageDTO) -> MainPageEntity {
        
        return MainPageEntity(naviTitle: alterToNaviEntity(from: dto), mainTitle: alterToFirstSectionEntity(from: dto), secondSection: alterToSecondSectionEntity(from: dto), thirdSection: alterToThirdSectionEntity(from: dto), fourthSection: alterToFourthSectionEntity(from: dto), fifthSection: alterToFifthSectionEntity(from: dto), SixthSection: alterToSixthSectionEntity(from: dto))
    }
}

// MARK: 하위 Entity 변환 메서드 모음

private extension ViewDefaultMainPageUsecase {
    
    func alterToNaviEntity(from dto: MainPageDTO) -> NavigationTitleEntity {
        let naviTitleImageURL = changeToURL(with: dto.artworkUrl60)
        
        return NavigationTitleEntity(navigationTitleImageURL: naviTitleImageURL, downloadURL: changeToURL(with: dto.trackViewURL))
    }
    
    func alterToFirstSectionEntity(from dto: MainPageDTO) -> MainTitleEntity {
        let appIconImageURL = changeToURL(with: dto.artworkUrl512)
        
        return MainTitleEntity(appIconImageURL: appIconImageURL, appName: dto.trackName, downloadURL: changeToURL(with: dto.trackViewURL))
    }
    
    func alterToSecondSectionEntity(from dto: MainPageDTO) -> [SubDescriptionEntity] {
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
                let temp = SubDescriptionEntity(index: $0.rawValue, title: "\(dto.userRatingCountForCurrentVersion)개의 평가", content: "\(round(dto.averageUserRating * 10) / 10)", extra: "★★★★☆")
                entities.append(temp)
                
            case .secondItem:
                let temp = SubDescriptionEntity(index: $0.rawValue, title: "연령", content: dto.trackContentRating, extra: "세")
                entities.append(temp)
                
            case .thirdItem:
                let temp = SubDescriptionEntity(index: $0.rawValue, title: "카테고리", content: "bubble.left.and.bubble.right.fill", extra: dto.genres[0])
                entities.append(temp)
                
            case .fourthItem:
                let temp = SubDescriptionEntity(index: $0.rawValue, title: "개발자", content: "person.crop.circle", extra: dto.artistName)
                entities.append(temp)
                
            case .fifthItem:
                let temp = SubDescriptionEntity(index: $0.rawValue, title: "언어", content: category, extra: "+ \(dto.languageCodesISO2A.count - 1)개의 언어")
                entities.append(temp)
            }
        }
        
        return entities
    }
    
    func alterToThirdSectionEntity(from dto: MainPageDTO) -> NewFeatureEntity {
        
        return NewFeatureEntity(version: dto.version, releaseNotes: dto.releaseNotes, updatedDate: calculateToday(from: dto.currentVersionReleaseDate))
    }
    
    func alterToFourthSectionEntity(from dto: MainPageDTO) -> [ScreenshotEntity] {
        var entities = [ScreenshotEntity]()
        
        dto.screenshotUrls.forEach {
            guard let url = changeToURL(with: $0) else { return }
            let temp = ScreenshotEntity(validURL: url)
            entities.append(temp)
        }
        
        return entities
    }
    
    func alterToFifthSectionEntity(from dto: MainPageDTO) -> DescriptionEntity {
        
        return DescriptionEntity(description: dto.description, programmerName: dto.artistName, programmerViewURL: changeToURL(with: dto.artistViewURL))
    }
    
    func alterToSixthSectionEntity(from dto: MainPageDTO) -> [SixthSectionEntity] {
        var entities = [SixthSectionEntity]()
        
        InfomationSection.allCases.forEach {
            switch $0 {
            case .firstItem:
                let temp = SixthSectionEntity(title: "제공자", content: dto.sellerName)
                entities.append(temp)
                
            case .secondItem:
                let temp = SixthSectionEntity(title: "크기", content: calculateMegaByte(from: dto.fileSizeBytes))
                entities.append(temp)
                
            case .thirdItem:
                let temp = SixthSectionEntity(title: "카테고리", content: dto.genres[0])
                entities.append(temp)
                
            case .fourthItem:
                let temp = SixthSectionEntity(title: "호환성", content: dto.minimumOSVersion)
                entities.append(temp)
                
            case .fifthItem:
                let temp = SixthSectionEntity(title: "언어", content: convertToString(from: dto.languageCodesISO2A))
                entities.append(temp)
                
            case .sixthItem:
                let temp = SixthSectionEntity(title: "연령 등급", content: dto.trackContentRating)
                entities.append(temp)
                
            case .seventhItem:
                let temp = SixthSectionEntity(title: "저작권", content: "© \(calculateYear(from: dto.releaseDate)) \(dto.sellerName)")
                entities.append(temp)
            }
        }
        
        return entities
    }
}

// MARK: 최하위 단위 변환 메서드 모음

private extension ViewDefaultMainPageUsecase {
    
    func changeToURL(with string: String) -> URL? {
        return URL(string: string)
    }
    
    func calculateToday(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSZ"
        guard let date = dateFormatter.date(from: date) else { return "" }
        
        let offsetComps = Calendar.current.dateComponents([.year, .month, .day, .hour], from: date, to: Date())
        
        if let year = offsetComps.year, year > 0 {
            return "\(year)년 전"
            
        } else if let month = offsetComps.month, month > 0 {
            return "\(month)개월 전"
            
        } else if let day = offsetComps.day, day > 0 {
            return "\(day)일 전"
            
        } else {
            return ""
        }
    }
    
    func calculateYear(from date: String) -> String {
        let temp = date.components(separatedBy: "-")
        return temp[0]
    }
    
    func calculateMegaByte(from byte: String) -> String {
        guard let realByte = Float(byte) else { return "" }
        
        let value = round((realByte / 1024000) * 10) / 10
        
        return "\(value)"
    }
    
    func convertToString(from iso: [String]) -> String {
        let isoDictionary = ["KO": "한국어", "EN": "영어"]
        var tempStrings = [String]()
        
        iso.forEach {
            guard let value = isoDictionary[$0] else { return }
            tempStrings.append(value)
        }
        
        return tempStrings.reduce("") { (result: String, next: String) -> String in
            return "\(result), \(next)"
        }
    }
}
