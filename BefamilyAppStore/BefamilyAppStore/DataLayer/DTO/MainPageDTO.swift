//
//  MainPageDTO.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import Foundation

struct MainPageDTO: Codable {
    let isGameCenterEnabled: Bool
    let supportedDevices: [String]
    let kind: String
    let artworkUrl512: String
    let artworkUrl100: String
    let artistViewURL: String
    let artworkUrl60: String
    let screenshotUrls: [String]
    let currentVersionReleaseDate: String
    let releaseNotes, primaryGenreName: String
    let primaryGenreID: Int
    let description, currency: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let sellerName, bundleID: String
    let genreIDS: [String]
    let releaseDate: String
    let trackID: Int
    let trackName, version, wrapperType, minimumOSVersion: String
    let trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes, formattedPrice, contentAdvisoryRating: String
    let averageUserRatingForCurrentVersion: Double
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let trackViewURL: String
    let trackContentRating: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price, userRatingCount: Int

    enum CodingKeys: String, CodingKey {
        case isGameCenterEnabled, supportedDevices, kind, artworkUrl512, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case artworkUrl60, screenshotUrls, currentVersionReleaseDate, releaseNotes, primaryGenreName
        case primaryGenreID = "primaryGenreId"
        case description, currency, isVppDeviceBasedLicensingEnabled, sellerName
        case bundleID = "bundleId"
        case genreIDS = "genreIds"
        case releaseDate
        case trackID = "trackId"
        case trackName, version, wrapperType
        case minimumOSVersion = "minimumOsVersion"
        case trackCensoredName, languageCodesISO2A, fileSizeBytes, formattedPrice, contentAdvisoryRating, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, averageUserRating
        case trackViewURL = "trackViewUrl"
        case trackContentRating
        case artistID = "artistId"
        case artistName, genres, price, userRatingCount
    }
}
