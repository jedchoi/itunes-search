//
//  GetAppListUseCase.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/19.
//

import Foundation
import ReactiveSwift

class GetAppListUseCase: UseCaseWithParam {
    typealias Param = String
    typealias ReturnValue = String
    var dataSource: ITunesAPIInterface!
    var disposables = CompositeDisposable()
    
    init() {
        Logger.track()
        self.dataSource = DependencyResolver.resolve(ITunesAPIInterface.self)
    }
    
    deinit {
        Logger.track()
        disposables.dispose()
    }

    func execute(param: Param) -> SignalProducer<ReturnValue, TraceError> {
        return SignalProducer { observer, lifetime in
            Logger.track()
            guard !lifetime.hasEnded else {
                Logger.track()
                observer.sendInterrupted()
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
                self.disposables.dispose()
            }
        }
    }
}
