//
//  EndPoint.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation

enum EndPoint: EndPointable {

    case mainPage
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        switch self {
        default:
            return "itunes.apple.com"
        }
    }
    
    var path: String {
        switch self {
        case .mainPage:
            return "/kr/lookup"
            
        default :
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .mainPage:
            return .get
        }
    }
    
    var contentType: [String: String] {
        switch self {
        default:
            return ["Content-type": "application/json",
                    "Accept": "application/json"]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .mainPage:
            return [URLQueryItem(name: "id", value: "1502953604")]
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path

        if self.httpMethod == .get {
            components.queryItems = self.queryItems
        }

        return components.url
    }
}
