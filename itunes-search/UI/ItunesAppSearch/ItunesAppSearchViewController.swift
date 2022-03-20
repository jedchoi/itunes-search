//
//  ItunesAppSearchViewController.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/20.
//

import Foundation
import UIKit

protocol ItunesAppSearchViewProtocol: AnyObject {
    // interactor -> View
    func updateUI(_ isConnected: Bool)
}

final class ItunesAppSearchViewController: UIViewController {
    var interactor: ItunesAppSearchInteractorInputProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.onViewDidLoad()
        setupUI()
    }

    func setupUI() {

    }
}

// MARK: - ViewProtocol

extension ItunesAppSearchViewController: ItunesAppSearchViewProtocol {
    func updateUI(_ isConnected: Bool) {
        DispatchQueue.main.async {
            Logger.track("")
        }
    }
}
