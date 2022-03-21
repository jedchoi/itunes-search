//
//  AppCollectionViewCell.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/21.
//
import UIKit
import Foundation

class AppCollectionViewCell: UICollectionViewCell {
    @IBOutlet var appIcon: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var priceButton: UIButton!
    
    @IBOutlet var screenShots: [UIImageView]!
    func configureCell(appInfo: ITunesSearchAppViewModel) {
        Logger.track()
        appIcon.load(from: appInfo.mainAppIconUrl)
        title.text = appInfo.title
        subTitle.text = appInfo.subTitle
        priceButton.titleLabel?.text = appInfo.price
        screenShots.forEach { screenShot in
            if appInfo.screenshotUrls.count > screenShot.tag {
                screenShot.load(from: appInfo.screenshotUrls[screenShot.tag])
            }
        }
    }
}
