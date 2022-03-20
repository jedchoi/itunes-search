//
//  RootInteractor.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/20.
//

import Foundation
import ReactiveSwift
import UIKit

protocol MainTabHomeInteractorInputProtocol: AnyObject {
    // View -> Interactor
}

final class MainTabHomeInteractor: MainTabHomeInteractorInputProtocol {
    weak var view: MainTabHomeViewProtocol!
    var wireframe: MainTabHomeWireframeProtocol!

    private var disposables = CompositeDisposable()

    init(view: MainTabHomeViewProtocol, wireframe: MainTabHomeWireframeProtocol) {
        self.view = view
        self.wireframe = wireframe
    }
}
