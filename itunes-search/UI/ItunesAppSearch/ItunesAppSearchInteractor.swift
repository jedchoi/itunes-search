//
//  ItunesAppSearchInteractor.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/20.
//

import Foundation
import ReactiveSwift

protocol ItunesAppSearchInteractorInputProtocol: AnyObject {
    func onViewDidLoad()
    func searchApp(key: String)
}

final class ItunesAppSearchInteractor {
    weak var view: ItunesAppSearchViewProtocol!
    private var wireframe: ItunesAppSearchWireframeProtocol!
    
    init(view: ItunesAppSearchViewProtocol, wireframe: ItunesAppSearchWireframeProtocol) {
        self.view = view
        self.wireframe = wireframe
    }
    
    private func getAppList(key: String) {
        let usecase = GetAppListUseCase()
        usecase.execute(param: key).startWithResult { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                guard let apps = try? JSONDecoder().decode([ITunesSearchAppViewModel].self, from: value.data(using: .utf8)!) else {
                    Logger.track("Decode Error")
                    return
                }
                apps.forEach({ $0.showAppTitle() })
                self.view.displayAppList(apps: apps)
            case .failure(let error):
                Logger.track("\(error.localizedDescription)")
            }
        }
    }
}


extension ItunesAppSearchInteractor: ItunesAppSearchInteractorInputProtocol {
    func onViewDidLoad() {
    }
    
    func searchApp(key: String) {
        getAppList(key: key)
    }
}
