//
//  ITunesAPIInterface.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/19.
//

import Foundation
import ReactiveSwift

protocol ITunesAPIInterface {
    /// *****************
    ///  getAppList
    ///  param: key is a simple string that you want to search
    ///  return type: This API returns result of the request as json string
    /// *****************
    func getAppList(key: String) -> SignalProducer<String, TraceError>
}
