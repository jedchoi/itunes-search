//
//  ITunesAppSearchingService.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/19.
//

import Foundation
import ReactiveSwift

protocol ITunesAppSearchingServiceInterface: AnyObject {
    var iTunesAppList: [ITunesAppEntity] { get set }
    func getAppList(key: String) -> SignalProducer<[ITunesAppEntity], TraceError>
    func getDetailAppInformation(title: String) -> SignalProducer<ITunesAppEntity, TraceError>
}

class ITunesAppSearchingService: ITunesAppSearchingServiceInterface {
    var iTunesAppList: [ITunesAppEntity]
    let dataSource: ITunesAPIInterface!
    var disposables = CompositeDisposable()
    
    init() {
        iTunesAppList = []
        dataSource = DependencyResolver.resolve(ITunesAPIInterface.self)
        
    }
    
    func getAppList(key: String) -> SignalProducer<[ITunesAppEntity], TraceError> {
        return SignalProducer { observer, lifetime in
            Logger.track()
            guard !lifetime.hasEnded else {
                observer.sendInterrupted()
                return
            }
            self.disposables += self.dataSource.getAppList(key: key).startWithResult({ result in
                switch result {
                case .success(let appList):
                    Logger.track()
                    guard let result = try? JSONDecoder().decode(ITunesAppSearchResult.self, from: appList.data(using: .utf8)!) else {
                        observer.send(error: TraceError(message: "Decode Error", code: "none"))
                        return
                    }
                    self.iTunesAppList = result.getItems()
                    result.showAppList()
                    observer.send(value: self.iTunesAppList)
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: error)
                }
            })
        }
    }
    
    func getDetailAppInformation(title: String) -> SignalProducer<ITunesAppEntity, TraceError> {
        return SignalProducer { observer, lifetime in
            Logger.track()
            guard !lifetime.hasEnded else {
                observer.sendInterrupted()
                return
            }
            if let app = self.iTunesAppList.first(where: {$0.title == title}) {
                observer.send(value: app)
                observer.sendCompleted()
            } else {
                self.disposables += self.getAppList(key: title).startWithResult({ result in
                    switch result {
                    case .success(let _):
                        if let app = self.iTunesAppList.first(where: {$0.title == title}) {
                            observer.send(value: app)
                            observer.sendCompleted()
                        } else {
                            observer.send(error: TraceError(message: "Not Found App Error", code: "404"))
                        }
                    case .failure(let error):
                        observer.send(error: error)
                    }
                })
            }
        }
    }

}
