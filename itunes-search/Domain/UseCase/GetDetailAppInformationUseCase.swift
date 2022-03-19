//
//  GetDetailAppInformationUseCase.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/19.
//

import Foundation
import ReactiveSwift

class GetDetailAppInformationUseCase: UseCaseWithParam {
    typealias Param = String
    typealias ReturnValue = ITunesAppEntity
    var dataSource: ITunesAppSearchingServiceInterface!
    var disposables = CompositeDisposable()
    
    init() {
        self.dataSource = DependencyResolver.resolve(ITunesAppSearchingServiceInterface.self)
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
            DispatchQueue.global().async {
                self.disposables += self.dataSource.getDetailAppInformation(title: param).startWithResult { result in
                    switch result {
                    case .success(let value):
                        Logger.track("\(value)")
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
}
