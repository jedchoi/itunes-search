//
//  DetailAppAttributeViewModel.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/24.
//

import Foundation

struct  DetailAppAttributeViewModel: Codable {
    var averageUserRating: Float
    var userRatingCount: Int
    var primaryGenreName: String
    var contentAdvisoryRating: String
    var sellerName: String
    var supportedLanguages: [String]

    enum CodingKeys: String, CodingKey {
        case averageUserRating = "averageUserRating"
        case userRatingCount = "userRatingCount"
        case primaryGenreName = "primaryGenreName"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case sellerName = "sellerName"
        case supportedLanguages = "languageCodesISO2A"
    }
}
    
