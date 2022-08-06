//
//  ViewDefaultMainPageUsecase.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import UIKit
import RxSwift

final class ViewDefaultMainPageUsecase {
    
    private var mainRepository: ViewMainPageRepository
    
    let disposeBag = DisposeBag()
    
    init(mainRepo: ViewMainPageRepository = ViewDefaultMainPageRepository()) {
        self.mainRepository = mainRepo
    }
    
    func executeMainData() {
        mainRepository.fetchDTO()
            .subscribe { [weak self] mainDTO in
                
                
            } onError: { <#Error#> in
                <#code#>
            } onCompleted: {
                <#code#>
            }.disposed(by: disposeBag)

    }
}

