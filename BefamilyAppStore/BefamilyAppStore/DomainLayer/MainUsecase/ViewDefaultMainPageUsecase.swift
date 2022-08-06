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
                
            }.disposed(by: disposeBag)
    }
}

private extension ViewDefaultMainPageUsecase {
    
    func alterToEntity(from dto: MainPageDTO) -> MainPageEntity {
        
        return MainPageEntity(naviTitle: alterToNaviEntity(from: dto), firstSection: alterToFirstSectionEntity(from: dto), secondSection: alterToSecondSectionEntity(from: dto), thirdSection: alterToThirdSectionEntity(from: dto), fourthSection: alterToFourthSectionEntity(from: dto), fifthSection: alterToFifthSectionEntity(from: dto), SixthSection: alterToSixthSectionEntity(from: dto))
    }
}

// MARK: 하위 Entity 변환 메서드 모음

private extension ViewDefaultMainPageUsecase {
    
    func alterToNaviEntity(from dto: MainPageDTO) -> NavigationTitleEntity {
        let naviTitleImageURL = changeToURL(with: dto.artworkUrl60)
        let downloadURL = changeToURL(with: dto.trackViewURL)
        
        return NavigationTitleEntity(navigationTitleImageURL: naviTitleImageURL, downloadURL: downloadURL)
    }
    
    func alterToFirstSectionEntity(from dto: MainPageDTO) -> FirstSectionEntity {
        let appIconImageURL = changeToURL(with: dto.artworkUrl512)
        let downloadURL = changeToURL(with: dto.trackViewURL)
        
        return FirstSectionEntity(appIconImageURL: appIconImageURL, appName: dto.trackName, downloadURL: downloadURL)
    }
    
    func alterToSecondSectionEntity(from dto: MainPageDTO) -> SecondSectionEntity {
        var category = ""
        
        if let koIndex = dto.genres.firstIndex(of: "KO") {
            category = dto.genres[koIndex]
        } else {
            category = dto.genres[0]
        }
        
        return SecondSectionEntity(ratingCount: "\(dto.userRatingCountForCurrentVersion)", averageRating: "\(round(dto.averageUserRating * 10) / 10)", trackContentRating: dto.trackContentRating, category: category, programmerName: dto.artistName, languageCodesISO2A: dto.languageCodesISO2A)
    }
    
    func alterToThirdSectionEntity(from dto: MainPageDTO) -> ThirdSectionEntity {
        
        return ThirdSectionEntity(version: dto.version, releaseNotes: dto.releaseNotes, updatedDate: calculateToday(from: dto.currentVersionReleaseDate))
    }
    
    func alterToFourthSectionEntity(from dto: MainPageDTO) -> FourthSectionEntity {

        return FourthSectionEntity(screenshotUrls: changeToURL(with: dto.screenshotUrls))
    }
    
    func alterToFifthSectionEntity(from dto: MainPageDTO) -> FifthSectionEntity {
        
        return FifthSectionEntity(description: dto.description, programmerName: dto.artistName, programmerViewURL: changeToURL(with: dto.artistViewURL))
    }
    
    func alterToSixthSectionEntity(from dto: MainPageDTO) -> SixthSectionEntity {
        
        return SixthSectionEntity(sellerName: dto.sellerName, fileSizeBytes: calculateMegaByte(from: dto.fileSizeBytes), categories: dto.genres, minimumOSVersion: dto.minimumOSVersion, languages: dto.languageCodesISO2A, ageRating: dto.trackContentRating, releaseDate: calculateYear(from: dto.releaseDate))
    }
}

// MARK: 최하위 단위 변환 메서드 모음

private extension ViewDefaultMainPageUsecase {
    
    func changeToURL(with string: String) -> URL? {
        return URL(string: string)
    }
    
    func changeToURL(with stringArrray: [String]) -> [URL?] {
        var tempArray = [URL?]()
        
        stringArrray.forEach {
            tempArray.append(URL(string: $0))
        }
        
        return tempArray
    }
    
    func calculateToday(from date: Date) -> String {
        let offsetComps = Calendar.current.dateComponents([.year, .month, .day, .hour], from: date, to: Date())
        
        if let year = offsetComps.year {
            return "\(year)"
            
        } else if let month = offsetComps.month {
            return "\(month)"
            
        } else if let day = offsetComps.day {
            return "\(day)"
            
        } else {
            return ""
        }
    }
    
    func calculateYear(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    func calculateMegaByte(from byte: String) -> String {
        guard let realByte = Float(byte) else { return "" }
        
        let value = round((realByte / 1024000) * 10) / 10
        
        return "\(value)"
    }
}
