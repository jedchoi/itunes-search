//
//  DetailNewFeatureViewModel.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/24.
//

import Foundation

struct DetailNewFeatureViewModel: Codable {
    var appVersion: String
    var releaseNotes: String
    var currentVersionReleaseDate: String

    enum CodingKeys: String, CodingKey {
        case appVersion = "version"
        case releaseNotes = "releaseNotes"
        case currentVersionReleaseDate = "currentVersionReleaseDate"
    }
}
