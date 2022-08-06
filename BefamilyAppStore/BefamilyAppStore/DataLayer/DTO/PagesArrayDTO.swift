//
//  PagesArrayDTO.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation

struct PagesArrayDTO: Codable {
    let resultCount: Int
    let results: [MainPageDTO]
}
