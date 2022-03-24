//
//  ITunesAppSearchingServiceInterface.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/24.
//

import Foundation
import ReactiveSwift

protocol ITunesAppSearchingServiceInterface: AnyObject {
    var iTunesAppList: [ITunesAppEntity] { get set }
    func getAppList(key: String) -> SignalProducer<[ITunesAppEntity], TraceError>
    func getDetailAppInformation(title: String) -> SignalProducer<ITunesAppEntity, TraceError>
}
