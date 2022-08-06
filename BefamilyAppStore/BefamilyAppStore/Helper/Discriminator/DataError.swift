//
//  DataError.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation

enum DataError: Error {
    case noData
    case decodingError
    case encodingError
}
