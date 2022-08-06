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
    
    func requestMainPageData() -> Observable<MainPageDTO> {
        
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else {
                observer.onError(ExtraError.rxGuardSelf)
                return Disposables.create()
            }
            
            self.networkService.request(endPoint: .mainPage)
                .subscribe { data in
                    
                    
                } onFailure: { _ in
                    observer.onError(DataError.noData)
                    
                }
                .disposed(by: self.disposeBag)

            return Disposables.create()
        }
    }
}
