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
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "검색"
        self.navigationController?.navigationBar.prefersLargeTitles = true
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

extension ItunesAppSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        Logger.track(searchController.searchBar.searchTextField.text ?? "")
        // if you want to show recommended list, implement this function
    }
}

extension ItunesAppSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let key = searchBar.text else {
            Logger.track("no text")
            return
        }
        Logger.track(key)
        interactor.searchApp(key: key)
    }
}
