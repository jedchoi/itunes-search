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
    @IBOutlet weak var screenshotCollectionView: DetailScreenShotCollectionView!
    @IBOutlet weak var descriptionView: DetailDescriptionView!
    @IBOutlet weak var descriptionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.onViewDidLoad()
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
            self.screenshotCollectionView.setup(data: encodedData)
            self.descriptionView.setup(data: encodedData, delegate: self)
        }
    }
}

extension ItunesAppDetailViewController: ItunesAppDetailViewProtocol {
    func displayAppDetail(app: ItunesAppDetailViewModel) {
        self.app = app
    }
}

extension ItunesAppDetailViewController: DetailNewFeatureHeightUpdateDelegate {
    func updateNewFeatureHeight(height: CGFloat) {
        Logger.track("text view height : \(height)")
        newFeatureViewHeightConstraint.constant = DETAIL_NEW_FEATURE_VIEW_DEFAULT_HEIGHT + (height - DETAIL_NEW_FEATURE_VIEW_TEXT_VIEW_DEFAULT_HEIGHT)
        detailViewHeightConstraint.constant += (height - DETAIL_NEW_FEATURE_VIEW_TEXT_VIEW_DEFAULT_HEIGHT)
    }
}

extension ItunesAppDetailViewController: DetailDescriptionHeightUpdateDelegate {
    func updateDescriptionHeight(height: CGFloat) {
        Logger.track("text view height : \(height)")
        descriptionViewHeightConstraint.constant = height
        detailViewHeightConstraint.constant += (height - DETAIL_DESCRIPTION_VIEW_TEXT_VIEW_DEFAULT_HEIGHT)
    }
}
