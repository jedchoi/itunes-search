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
    var app: ItunesAppDetailViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.onViewDidLoad()
    }
    
    private func updateUI() {
        
    }
}

extension ItunesAppDetailViewController: ItunesAppDetailViewProtocol {
    func displayAppDetail(app: ItunesAppDetailViewModel) {
        self.app = app
    }
}
