//
//  DetailAppTitleViewModel.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/24.
//

import Foundation

struct DetailAppTitleViewModel: Codable {
    var mainAppIconUrl: String
    var title: String
    var price: String
    var sellerName: String

    enum CodingKeys: String, CodingKey {
        case mainAppIconUrl = "artworkUrl512"
        case title = "trackName"
        case price = "formattedPrice"
        case sellerName = "sellerName"
    }
}
    
