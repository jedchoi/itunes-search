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
    @IBOutlet weak var screenshotCollectionView: DetailScreenShotView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.onViewDidLoad()
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.updateAppTitleView()

        }
    }
    
    private func updateAppTitleView() {
        guard let data = try? JSONEncoder().encode(app), let encodedData = String.init(data: data, encoding: .utf8) else {
            Logger.track("Encode Error")
            return
        }
        titleView.setup(data: encodedData)
        attributeView.setup(data: encodedData)
        newFeatureView.setup(data: encodedData, delegate: self)
        screenshotCollectionView.setup(data: encodedData, height: self.view.frame.height)
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

extension ItunesAppDetailViewController: DetailScreenShotGetHeightDelegate {
    func getHeight() -> CGFloat {
        Logger.track("collection view height : \(self.view.frame.height)")
       return self.view.frame.height
    }
}
