//
//  ItunesAppSearchViewModel.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/20.
//

import Foundation

struct ITunesSearchAppViewModel: Codable {
    var id: Int
    var mainAppIconUrl: String
    var title: String
    var subTitle: String
    var averageUserRating: Float
    var userRatingCount: Int
    var price: String
    var screenshotUrls: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case mainAppIconUrl = "artworkUrl512"
        case title = "trackName"
        case subTitle = "trackCensoredName"
        case averageUserRating = "averageUserRating"
        case userRatingCount = "userRatingCount"
        case price = "formattedPrice"
        case screenshotUrls = "screenshotUrls"
    }
    
    func showAppTitle() {
        Logger.track("title: \(title)")
    }
}
