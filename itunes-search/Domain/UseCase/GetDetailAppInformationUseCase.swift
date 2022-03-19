//
//  GetDetailAppInformation.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/19.
//

import Foundation
import ReactiveSwift

class GetDetailAppInformation: UseCaseWithParam {
    typealias Param = String
    typealias ReturnValue = String
    var dataSource: ITunesAPIInterface!
    var disposables = CompositeDisposable()
    
    init() {
        self.dataSource = DependencyResolver.resolve(ITunesAPIInterface.self)
    }
    
    deinit {
        disposables.dispose()
    }

    func execute(param: Param) -> SignalProducer<ReturnValue, TraceError> {
        return SignalProducer { [weak self] observer, _ in
            Logger.track()
            guard let self = self else {
                observer.send(error: TraceError(message: "self is nil"))
                return
            }
            self.disposables += self.dataSource.getAppList(key: param).startWithResult { result in
                switch result {
                case .success(let value):
                    Logger.track(value)
                    observer.send(value: value)
                    observer.sendCompleted()
                case .failure(let error):
                    Logger.track(error.message)
                    observer.send(error: error)
                }
            }
        }
    }
}
