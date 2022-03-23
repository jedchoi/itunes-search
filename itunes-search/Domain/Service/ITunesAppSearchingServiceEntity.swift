//
//  ITunesAppSearchingServiceEntity.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/19.
//

import Foundation
struct ITunesAppSearchResult: Codable {
    var resultCount: Int
    var results: [ITunesAppEntity]?
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results = "results"
    }
    
    func showAppList() {
        Logger.track("resultCount: \(resultCount)")
        results?.forEach({ Logger.track("App Name : \($0.title)") })
    }
    
    func getItems() -> [ITunesAppEntity] {
        return results ?? []
    }
}

struct ITunesAppEntity: Codable {
    var id: Int
    var mainAppIconUrl: String
    var title: String
    var subTitle: String
    var averageUserRating: Float
    var userRatingCount: Int
    var price: String
    var screenshotUrls: [String]
    var sellerName: String
    var primaryGenreName: String
    var contentAdvisoryRating: String
    var appVersion: String
    var releaseNotes: String
    var description: String
    var currentVersionReleaseDate: String
    var supportedLanguages: [String]

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case mainAppIconUrl = "artworkUrl512"
        case title = "trackName"
        case subTitle = "trackCensoredName"
        case averageUserRating = "averageUserRating"
        case userRatingCount = "userRatingCount"
        case price = "formattedPrice"
        case screenshotUrls = "screenshotUrls"
        case sellerName = "sellerName"
        case primaryGenreName = "primaryGenreName"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case appVersion = "version"
        case releaseNotes = "releaseNotes"
        case description = "description"
        case currentVersionReleaseDate = "currentVersionReleaseDate"
        case supportedLanguages = "languageCodesISO2A"
    }
}
