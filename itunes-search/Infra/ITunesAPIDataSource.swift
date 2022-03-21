//
//  ITunesAPIDataSource.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/21.
//
import Foundation
import ReactiveSwift

class ITunesAPIDataSource: ITunesAPIInterface {
    let session = URLSession.shared
    
    func getAppList(key: String) -> SignalProducer<String, TraceError> {
        return SignalProducer { observer, lifetime in
            guard !lifetime.hasEnded else {
                observer.sendInterrupted()
                return
            }

            guard let url = self.buildUrl(term: key) else {
                observer.send(error: TraceError(message: "url error", code: ""))
                return
            }
            let task = self.session.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    observer.send(error: TraceError(error: error))
                    return
                }
                
                observer.send(value: String(data: data, encoding: .utf8) ?? "")
            }
            task.resume()
        }
    }

    func buildUrl(term: String) -> URL? {
        let parameters = ["term":term, "country":"KR","media":"software","limit":"10"]

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "itunes.apple.com"
        urlComponents.path = "/search"
        urlComponents.queryItems = parameters.map { (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        }
        
        return urlComponents.url
    }
}
