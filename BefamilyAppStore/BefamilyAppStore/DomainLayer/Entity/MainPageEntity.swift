//
//  MainPageEntity.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation

struct MainPageEntity {
    // SECTION : Navigation Title (trackViewURL도 추가 필요)
    let artworkUrl60: String
    
    // SECTION : First Section
    let artworkUrl512: String
    let trackName: String
    let trackViewURL: URL
    
    // SECTION : Second Section
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Float
    
    let trackContentRating: String
    
    let genres: [String]
    
    let artistName: String
    
    let languageCodesISO2A: [String]
    
    // SECTION : Third Section
    let version: String
    let releaseNotes: String
    
    let currentVersionReleaseDate: Date
    
    // SECTION : Fourth Section
    let screenshotUrls: [URL]
    
    // SECTION : Fifth Section (artistName 추가 필요)
    let description: String
    
    let artistViewURL: URL
    
    // SECTION : Sixth Section (genres, languageCodesISO2A, trackContentRating 추가 필요)
    let sellerName: String
    let fileSizeBytes: Float
    
    let minimumOSVersion: String
    
    let releaseDate: String
}
