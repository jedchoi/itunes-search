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
    
    @IBOutlet var appIconImageView: UIImageView!
    @IBOutlet var appTitle: UILabel!
    @IBOutlet var artist: UILabel!
    @IBOutlet var priceButton: UIButton!
    
    
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
        appIconImageView.load(from: app.mainAppIconUrl)
        appTitle.text = app.title
        artist.text = app.sellerName
        priceButton.titleLabel?.text = app.price
    }
}

extension ItunesAppDetailViewController: ItunesAppDetailViewProtocol {
    func displayAppDetail(app: ItunesAppDetailViewModel) {
        self.app = app
    }
}
