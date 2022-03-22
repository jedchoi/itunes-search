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
    var genres: [String]
    var contentAdvisoryRating: String
    var appVersion: String
    var releaseNotes: String
    var description: String

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
        case genres = "genres"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case appVersion = "version"
        case releaseNotes = "releaseNotes"
        case description = "description"
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
        genres = []
        contentAdvisoryRating = ""
        appVersion = ""
        releaseNotes = ""
        description = ""
    }
    
    func showAppTitle() {
        Logger.track("title: \(title)")
    }
}
