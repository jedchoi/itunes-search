//
//  DetailScreenShotView.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/23.
//

import Foundation
import UIKit

class DetailScreenShotCollectionView: UICollectionView {
    var data: ItunesDetailScreenShotViewModel! {
        didSet {
            DispatchQueue.main.async {
                Logger.track()
              self.reloadData()
            }
        }
    }
    
    func setup(data: String) {
        guard let appData = try? JSONDecoder().decode(ItunesDetailScreenShotViewModel.self, from: data.data(using: .utf8)!) else {
            Logger.track("Decode Error : \(data)")
            return
        }
        self.data = appData
        self.dataSource = self
        self.delegate = self
    }
}

extension DetailScreenShotCollectionView: UICollectionViewDataSource {
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

extension DetailScreenShotCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Logger.track()
        return CGSize(width: collectionView.frame.height * 0.58 , height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


struct ItunesDetailScreenShotViewModel: Codable {
    var screenshotUrls: [String]

    enum CodingKeys: String, CodingKey {
        case screenshotUrls = "screenshotUrls"
    }
}
    
