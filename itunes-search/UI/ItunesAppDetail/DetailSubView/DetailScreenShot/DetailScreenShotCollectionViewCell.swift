//
//  DetailScreenShotCollectionViewCell.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/23.
//

import UIKit


class DetailScreenShotCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var screenshot: UIImageView!
    func configureCell(url: String) {
        Logger.track()
        screenshot.load(from: url)
        screenshot.cornerRadius = 10
    }
}
