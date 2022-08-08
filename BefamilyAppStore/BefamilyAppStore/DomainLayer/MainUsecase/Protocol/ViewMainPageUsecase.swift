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
    var naviTitleImageSubject: PublishSubject<UIImage> { get }
    var mainImageSubject: PublishSubject<UIImage> { get }
    var screenshotsSubject: PublishSubject<[UIImage]> { get }
    
    func executeMainData()
    func executeNaviTitleImage(with url: URL?)
    func executeMainTitleImage(with url: URL?)
    func executeScreenshots(with entities: [ScreenshotEntity])
}
