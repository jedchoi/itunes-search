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
    var dataSource: ITunesAppSearchingServiceInterface!
    var disposables = CompositeDisposable()
    
    init() {
        Logger.track()
        self.dataSource = DependencyResolver.resolve(ITunesAppSearchingServiceInterface.self)
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
            DispatchQueue.global().async {
                self.disposables += self.dataSource.getAppList(key: param).startWithResult { result in
                    switch result {
                    case .success(let value):
                        // Encode data to remove dependency between Entity(domain) and ViewModel(UI)
                        guard let data = try? JSONEncoder().encode(value), let encodedAppList = String.init(data: data, encoding: .utf8) else {
                            observer.send(error: TraceError(message: "encoding error", code: ""))
                            return
                        }
                        observer.send(value: encodedAppList)
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
}
