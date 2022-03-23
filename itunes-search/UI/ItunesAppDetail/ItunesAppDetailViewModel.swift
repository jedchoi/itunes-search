//
//  ITunesAppDetailViewModel.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/22.
//

import Foundation

struct ItunesAppDetailViewModel: Codable {
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
    
    init() {
        id = 123456
        mainAppIconUrl = ""
        title = ""
        subTitle = ""
        averageUserRating = 0.0
        userRatingCount = 0
        price = "무료"
        screenshotUrls = []
        sellerName = ""
        primaryGenreName = ""
        contentAdvisoryRating = ""
        appVersion = ""
        releaseNotes = ""
        description = ""
        currentVersionReleaseDate = ""
        supportedLanguages = []
    }
    
    func showAppTitle() {
        Logger.track("title: \(title)")
    }
}
