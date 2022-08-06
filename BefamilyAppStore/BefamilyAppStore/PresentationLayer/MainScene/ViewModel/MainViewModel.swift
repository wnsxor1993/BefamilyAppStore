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
                
            } onError: { _ in
                
            }
            .disposed(by: disposeBag)

        return output
    }
    
    func enquireMainPageData() {
        mainUsecase.executeMainData()
    }
}
