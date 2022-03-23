//
//  DetailScreenShotCollectionViewCell.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/24.
//
import UIKit
import Foundation


class DetailScreenShotCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    func configureCell(url: String) {
        imageView.load(from: url)
        imageView.cornerRadius = 10
    }
}
