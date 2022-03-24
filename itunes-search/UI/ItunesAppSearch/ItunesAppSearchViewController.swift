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
    func displayAppList(apps: [ITunesSearchAppViewModel])
}

final class ItunesAppSearchViewController: UIViewController {
    var interactor: ItunesAppSearchInteractorInputProtocol!
    var apps: [ITunesSearchAppViewModel] = []
    @IBOutlet var appListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.onViewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setupCollectionViewDelegate()
        setupSearchController()
    }
    
    private func setupCollectionViewDelegate() {
        appListCollectionView.delegate = self
        appListCollectionView.dataSource = self
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
        DispatchQueue.main.async {
            self.appListCollectionView.reloadData()
        }
    }
}

extension ItunesAppSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // if you want to show recommended list, implement this function
    }
}

extension ItunesAppSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let key = searchBar.text else {
            Logger.track("no text")
            return
        }
        interactor.searchApp(key: key)
    }
}

extension ItunesAppSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < apps.count else {
            Logger.track("indexPath: \(indexPath), apps.coount: \(apps.count)")
            return
        }

        interactor.itemDidSelect(title: apps[indexPath.item].title)
    }
}

extension ItunesAppSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCollectionViewCell", for: indexPath) as? AppCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(appInfo: apps[indexPath.item])
        return cell
    }
}

extension ItunesAppSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width*0.85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}
