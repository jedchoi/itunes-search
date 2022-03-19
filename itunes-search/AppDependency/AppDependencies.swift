//
//  AppDependencies.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/19.
//

import Foundation
import Swinject
import UIKit

let DependencyAssembler = AppDependencies.share.assembler
let DependencyResolver = AppDependencies.share.assembler.resolver

class AppDependencies {

    static let share = AppDependencies()

    let assembler = Assembler([
        FakeItunesSearchDependencyAssembly()
    ])
}
