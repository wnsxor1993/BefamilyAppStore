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
    var screenshotImagesSubject: PublishSubject<[UIImage]> { get }
    
    func executeMainData()
    func executeScreenshots(with entities: [FourthSectionEntity])
}
