//
//  ViewMainPageRepository.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation
import RxSwift

protocol ViewMainPageRepository {
    
    func fetchDTO() -> Observable<MainPageDTO>
    func searchImage(with url: URL?) -> Observable<UIImage>
    func searchImagesArray(with entities: [ScreenshotEntity]) -> Observable<[UIImage]>
}
