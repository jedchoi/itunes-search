//
//  DetailScreenShotView.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/23.
//

import Foundation
import UIKit

protocol DetailScreenShotGetHeightDelegate: AnyObject {
    func getHeight() -> CGFloat
}

class DetailScreenShotView: UICollectionView {
    var heightDelegate: DetailScreenShotGetHeightDelegate?
    var parentHeight: CGFloat = 0.0
    var data: ItunesDetailScreenShotViewModel! {
        didSet {
            DispatchQueue.main.async {
                Logger.track()
              self.reloadData()
            }
        }
    }
    
    func setup(data: String, height: CGFloat) {
        guard let appData = try? JSONDecoder().decode(ItunesDetailScreenShotViewModel.self, from: data.data(using: .utf8)!) else {
            Logger.track("Decode Error : \(data)")
            return
        }
        self.data = appData
        self.parentHeight = height
        Logger.track()

//        self.register(UINib.init(nibName: "DetailScreenShotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailScreenShotCollectionViewCell")
        self.dataSource = self
    }
}

extension DetailScreenShotView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.screenshotUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailScreenShotCollectionViewCell", for: indexPath) as? DetailScreenShotCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(url: data.screenshotUrls[indexPath.item])
        return cell
    }
}

extension DetailScreenShotView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let heightDelegate = self.heightDelegate else {
//            Logger.track("no delegate")
//            return CGSize(width: 100, height: 200)
//        }
//        return CGSize(width: heightDelegate.getHeight() * 0.9 / 2, height: heightDelegate.getHeight() * 0.9)
        Logger.track()
        return CGSize(width: parentHeight * 0.8 / 2, height: parentHeight * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


struct ItunesDetailScreenShotViewModel: Codable {
    var screenshotUrls: [String]

    enum CodingKeys: String, CodingKey {
        case screenshotUrls = "screenshotUrls"
    }
}
    
