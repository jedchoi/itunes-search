//
//  DetailAppAttributeView.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/23.
//

import UIKit
import Cosmos

class DetailAppAttributeView: UIView {
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var userRatingCountLabel: UILabel!
    
    @IBOutlet weak var genreTitle: UILabel!
    @IBOutlet weak var genreRanking: UILabel!
    
    @IBOutlet weak var advisory: UILabel!
    @IBOutlet weak var developer: UILabel!
    @IBOutlet weak var language: UILabel!
    
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
        guard let appData = try? JSONDecoder().decode(DetailAppAttributeViewModel.self, from: data.data(using: .utf8)!) else {
            Logger.track("Decode Error : \(data)")
            return
        }
        ratingView.rating = Double(appData.averageUserRating)
        ratingView.text = String(format: "%.1f", appData.averageUserRating)
        userRatingCountLabel.text = getUserRatingCount(value: appData.userRatingCount)
        genreTitle.text = appData.primaryGenreName
        genreRanking.text = "#2"
        advisory.text = appData.contentAdvisoryRating
        developer.text = appData.sellerName
        language.text = appData.supportedLanguages.first
//        appIconImageView.load(from: appData.mainAppIconUrl)
//        appTitle.text = appData.title
//        seller.text = appData.sellerName
//        priceButton.titleLabel?.text = appData.price
    }
    
    private func getUserRatingCount(value: Int) -> String {
        var result: String = ""
        let digit = String(value).count
        if digit == 4 {
            result = String(format: "%0.1f", Float(value)/1000)+"천"
        } else if digit > 4 {
            result = String(format: "%0.1f", Float(value)/10000)+"만"
        }
        return result
    }
}
