//
//  DetailAppAttributeView.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/23.
//

import UIKit

class DetailAppAttributeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        guard let view = UINib(nibName: "DetailAppAttributeView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            Logger.track("fail to load xib")
            return
        }
        
        view.frame = bounds
        addSubview(view)
    }
    
    func setup(data: String) {
        guard let appData = try? JSONDecoder().decode(ItunesDetailAppAttributeViewModel.self, from: data.data(using: .utf8)!) else {
            Logger.track("Decode Error : \(data)")
            return
        }
//        appIconImageView.load(from: appData.mainAppIconUrl)
//        appTitle.text = appData.title
//        seller.text = appData.sellerName
//        priceButton.titleLabel?.text = appData.price
    }
}

struct ItunesDetailAppAttributeViewModel: Codable {
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
    
