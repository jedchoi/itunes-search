//
//  DetailScreenShotCollectionViewMobel.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/24.
//

import Foundation


struct DetailScreenShotCollectionViewMobel: Codable {
    var screenshotUrls: [String]

    enum CodingKeys: String, CodingKey {
        case screenshotUrls = "screenshotUrls"
    }
}
    
