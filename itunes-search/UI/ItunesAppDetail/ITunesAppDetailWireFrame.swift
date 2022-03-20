//
//  ITunesAppDetailWireFrame.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/20.
//

import Foundation
import UIKit

protocol ITunesAppDetailWireFrameProtocol: AnyObject {
    // Interactor -> Wireframe
    func route()
    func back()
}

final class ITunesAppDetailWireFrame {
    weak var view: ItunesAppSearchViewController?
    private var appTitle: String!

    init(title: String) {
        appTitle = title
    }

    func setup() {
//        let view = ItunesAppSearchViewController.instantiate(.ItunesAppSearch)
//        let interactor = ItunesAppSearchInteractor(view: view, wireframe: self)
//
//        view.interactor = interactor
//        self.view = view
    }

    func push(from presentedViewController: UIViewController) {
        guard let view = self.view else {
            Logger.track("fail to push")
            return
        }
        presentedViewController.navigationController?.pushViewController(view, animated: true)
    }
}

extension ITunesAppDetailWireFrame: ITunesAppDetailWireFrameProtocol {
    func route() {
    }
    
    func back() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let view = self.view else {
                Logger.track("fail to route")
                return
            }
            view.navigationController?.popViewController(animated: false)
        }
    }
}
