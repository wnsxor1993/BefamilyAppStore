//
//  NetworkServiceable.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation
import RxSwift

protocol NetworkServiceable {

    func request(endPoint: EndPoint) -> Single<Data>
}
