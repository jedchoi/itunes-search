//
//  DetailDescriptionViewModel.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/24.
//

import UIKit

public let DETAIL_DESCRIPTION_VIEW_TEXT_VIEW_DEFAULT_HEIGHT: CGFloat = 65.0

struct DetailDescriptionViewModel: Codable {
    var description: String

    enum CodingKeys: String, CodingKey {
        case description = "description"
    }
}
    
