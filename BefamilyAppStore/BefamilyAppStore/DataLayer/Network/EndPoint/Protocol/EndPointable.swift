//
//  EndPointable.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation

protocol EndPointable {
    
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var contentType: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
    var url: URL? { get }
}
