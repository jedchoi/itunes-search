//
//  ITunesAppDetailInteractor.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/22.
//

import Foundation
import ReactiveSwift

protocol ItunesAppDetailInteractorInputProtocol: AnyObject {
    func onViewDidLoad()
}

final class ItunesAppDetailInteractor {
    weak var view: ItunesAppDetailViewProtocol!
    private var wireframe: ItunesAppDetailWireFrameProtocol!
    private var app: ItunesAppDetailViewModel!
    private let title: String!
    
    init(view: ItunesAppDetailViewProtocol, wireframe: ItunesAppDetailWireFrameProtocol, title: String) {
        self.view = view
        self.wireframe = wireframe
        self.title = title
    }
    
    private func getAppDetail() {
        let usecase = GetDetailAppInformationUseCase()
        usecase.execute(param: title).startWithResult { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                guard let app = try? JSONDecoder().decode(ItunesAppDetailViewModel.self, from: value.data(using: .utf8)!) else {
                    Logger.track("Decode Error : \(value)")
                    return
                }
                app.showAppTitle()
                self.app = app
                self.view.displayAppDetail(app: app)
            case .failure(let error):
                Logger.track("\(error.localizedDescription)")
            }
        }
    }
}


extension ItunesAppDetailInteractor: ItunesAppDetailInteractorInputProtocol {
    func onViewDidLoad() {
        getAppDetail()
    }
    
    func searchApp(key: String) {
//        getAppList(key: key)
    }
    
    func itemDidSelect(title: String) {
//        wireframe.routeToDetail(title: title)
    }
}
