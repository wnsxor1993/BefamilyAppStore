//
//  ViewMainPageUsecase.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation
import RxSwift

protocol ViewMainPageUsecase {
    
    var mainPageEntitySubject: PublishSubject<MainPageEntity> { get }
    
    func executeMainData()
}
