//
//  MainPageEntity.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation

struct MainPageEntity {
    let naviTitle: NavigationTitleEntity
    let firstSection: FirstSectionEntity
    let secondSection: [SecondSectionEntity]
    let thirdSection: ThirdSectionEntity
    let fouthSection: [FourthSectionEntity]
    let fifthSection: FifthSectionEntity
    let SixthSection: SixthSectionEntity
}
//
//// SECTION : Navigation Title (downloadURL도 추가 필요)
//let navigationTitleImageURL: URL?
//
//// SECTION : First Section
//let appIconImageURL: String
//let appName: String
//let downloadURL: URL?
//
//// SECTION : Second Section
//let ratingCount: String
//let averageRating: String
//
//let trackContentRating: String
//
//let category: String
//
//let programmerName: String
//
//let languageCodesISO2A: [String]
//
//// SECTION : Third Section
//let version: String
//let releaseNotes: String
//
//let updatedDate: String
//
//// SECTION : Fourth Section
//let screenshotUrls: [URL?]
//
//// SECTION : Fifth Section (artistName 추가 필요)
//let description: String
//
//let artistViewURL: URL
//
//// SECTION : Sixth Section (genres, languageCodesISO2A, trackContentRating 추가 필요)
//let sellerName: String
//let fileSizeBytes: String
//
//let minimumOSVersion: String
//
//let releaseDate: String
