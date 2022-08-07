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
    var imageSubject: PublishSubject<UIImage> { get }
    var imagesArraySubject: PublishSubject<[UIImage]> { get }
    
    func executeMainData()
    func executeMainTitleImage(with url: URL?)
    func executeScreenshots(with entities: [ScreenshotEntity])
}
