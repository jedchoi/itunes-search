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
    func displayAppList(apps: [ITunesSearchAppViewModel])
}

final class ItunesAppSearchViewController: UIViewController {
    var interactor: ItunesAppSearchInteractorInputProtocol!
    var apps: [ITunesSearchAppViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.onViewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setupSearchController()
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController:  nil)
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.shadowImage = nil
    }
}

// MARK: - ViewProtocol
extension ItunesAppSearchViewController: ItunesAppSearchViewProtocol {
    func displayAppList(apps: [ITunesSearchAppViewModel]) {
        Logger.track("")
        self.apps = apps
    }
    
    func updateUI(_ isConnected: Bool) {
        DispatchQueue.main.async {
            Logger.track("")
        }
    }
}
