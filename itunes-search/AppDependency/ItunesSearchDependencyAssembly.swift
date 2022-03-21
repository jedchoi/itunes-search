//
//  ItunesSearchDependencyAssembly.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/19.
//

import Foundation
import Swinject

class ItunesSearchDependencyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ITunesAPIInterface.self) { _ in ITunesAPIDataSource() }
        container.register(ITunesAppSearchingServiceInterface.self) { _ in ITunesAppSearchingService() }
        Logger.track()
    }
}
