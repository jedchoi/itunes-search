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
    }
}

extension ItunesAppDetailViewController: ItunesAppDetailViewProtocol {
    func displayAppDetail(app: ItunesAppDetailViewModel) {
        self.app = app
    }
}
