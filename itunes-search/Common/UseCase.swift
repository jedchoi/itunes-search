//
//  UseCase.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/19.
//

import Foundation
import ReactiveSwift

protocol UseCase: AnyObject {
    func execute()
}

protocol UseCaseWithParam: AnyObject {
    associatedtype Param
    associatedtype ReturnValue

    func execute(param: Param) -> SignalProducer<ReturnValue, TraceError>
}
