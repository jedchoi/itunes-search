//
//  ITunesAppDetailViewController.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/22.
//

import Foundation
import UIKit

protocol ItunesAppDetailViewProtocol: AnyObject {
    // interactor -> View
    func displayAppDetail(app: ItunesAppDetailViewModel)
}

final class ItunesAppDetailViewController: UIViewController {
    var interactor: ItunesAppDetailInteractorInputProtocol!
    var app: ItunesAppDetailViewModel = ItunesAppDetailViewModel() {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var titleView: DetailAppTitleView!
    @IBOutlet weak var attributeView: DetailAppAttributeView!
    @IBOutlet weak var newFeatureView: DetailNewFeatureView!
    @IBOutlet weak var newFeatureViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var screenhotCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.onViewDidLoad()
        screenhotCollectionView.dataSource = self
        screenhotCollectionView.delegate = self
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            guard let data = try? JSONEncoder().encode(self.app), let encodedData = String.init(data: data, encoding: .utf8) else {
                Logger.track("Encode Error")
                return
            }
            self.titleView.setup(data: encodedData)
            self.attributeView.setup(data: encodedData)
            self.newFeatureView.setup(data: encodedData, delegate: self)
            self.screenhotCollectionView.reloadData()
        }
    }
}

extension ItunesAppDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app.screenshotUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailScreenShotCollectionViewCell", for: indexPath) as? DetailScreenShotCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(url: app.screenshotUrls[indexPath.item])
        return cell
    }
}

extension ItunesAppDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height*0.58, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


extension ItunesAppDetailViewController: ItunesAppDetailViewProtocol {
    func displayAppDetail(app: ItunesAppDetailViewModel) {
        self.app = app
    }
}

extension ItunesAppDetailViewController: DetailNewFeatureHeightUpdateDelegate {
    func updateHeight(height: CGFloat) {
        Logger.track("text view height : \(height)")
        newFeatureViewHeightConstraint.constant = DETAIL_NEW_FEATURE_VIEW_DEFAULT_HEIGHT + (height - DETAIL_NEW_FEATURE_VIEW_TEXT_VIEW_DEFAULT_HEIGHT)
    }
}
