//
//  NetworkError.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation

enum NetworkError: Error {
    case noURL
    case transportError(Error)
    case serverError(statusCode: Int)
}
