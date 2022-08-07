//
//  ViewDefaultMainPageRepository.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation
import RxSwift

final class ViewDefaultMainPageRepository: ViewMainPageRepository {
    
    let networkService = NetworkService()
    let disposeBag = DisposeBag()
    
    func fetchDTO() -> Observable<MainPageDTO> {
        
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else {
                observer.onError(ExtraError.rxGuardSelf)
                return Disposables.create()
            }
            
            self.networkService.request(endPoint: .mainPage)
                .subscribe { data in
                    let jsonConverter = JSONConverter<PagesArrayDTO>()
                    guard let pagesArrayDTO = jsonConverter.decode(data: data) else {
                        observer.onError(DataError.decodingError)
                        return
                    }
                    
                    if pagesArrayDTO.resultCount == 1 {
                        observer.onNext(pagesArrayDTO.results[0])
                    } else {
                        observer.onError(ExtraError.mainPageDTOCountNotOne)
                    }
                    
                } onFailure: { _ in
                    observer.onError(DataError.noData)
                    
                }
                .disposed(by: self.disposeBag)

            return Disposables.create()
        }
    }
    
    func searchImage(with entities: [FourthSectionEntity]) -> Observable<[UIImage]> {
        
        return Observable.create { observer -> Disposable in
            var tempImages = [UIImage]()
            
            entities.forEach {
                if let cachedImage = ImageCacheService.loadData(url: $0.validURL) {
                    tempImages.append(cachedImage)
                    
                } else {
                    guard let image = UIImage(data: $0.screenshots) else { return }
                    
                    ImageCacheService.saveData(image: image, url: $0.validURL)
                    tempImages.append(image)
                }
            }
            
            observer.onNext(tempImages)
            
            return Disposables.create()
        }
    }
}
