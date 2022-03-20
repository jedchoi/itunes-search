//
//  ItunesAppSearchWireframe.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/20.
//

import Foundation
import UIKit

protocol ItunesAppSearchWireframeProtocol: AnyObject {
    // Interactor -> Wireframe
    func routeToDetail(title: String)
}

final class ItunesAppSearchWireframe: TabBarInterface {
    weak var view: UIViewController!

    init() {
    }

    func setup() {
        let view = ItunesAppSearchViewController.instantiate(.ItunesAppSearch)
        let interactor = ItunesAppSearchInteractor(view: view, wireframe: self)

        view.interactor = interactor
        self.view = view
    }
    
    func configuredViewController() -> UIViewController {
        return view
    }

    func push(from presentedViewController: UIViewController) {
        guard let view = self.view else {
            Logger.track("fail to present")
            return
        }
        view.navigationController?.pushViewController(view, animated: true)
    }
    
}

extension ItunesAppSearchWireframe: ItunesAppSearchWireframeProtocol {
    func routeToDetail(title: String) {
        guard let view = self.view else {
            Logger.track("fail to present")
            return
        }
        Logger.track("route to detail page")
        
        let wireframe = ITunesAppDetailWireFrame(title: title)
        wireframe.setup()
        wireframe.push(from: view)
    }
}
