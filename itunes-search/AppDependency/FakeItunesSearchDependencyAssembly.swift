//
//  FakeItunesSearchDependencyAssembly.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/19.
//

import Foundation
import Swinject

class FakeItunesSearchDependencyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ITunesAPIInterface.self) { _ in FakeITunesAPIDataSource() }
        Logger.track()
    }
}
