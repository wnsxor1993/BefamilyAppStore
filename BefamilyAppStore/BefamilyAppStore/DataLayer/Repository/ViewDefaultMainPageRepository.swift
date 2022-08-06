//
//  ViewDefaultMainPageRepository.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation
import RxSwift

final class ViewDefaultMainPageRepository {
    
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
}
