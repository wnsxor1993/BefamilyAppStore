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
    func searchImage(with entities: [FourthSectionEntity]) -> Observable<[UIImage]>
}
