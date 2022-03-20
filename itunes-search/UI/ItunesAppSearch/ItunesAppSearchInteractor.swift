//
//  ItunesAppSearchInteractor.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/20.
//

import Foundation
protocol ItunesAppSearchInteractorInputProtocol: AnyObject {
    func onViewDidLoad()
    func searchApp(key: String)
}

final class ItunesAppSearchInteractor {
    weak var view: ItunesAppSearchViewProtocol!
    private var wireframe: ItunesAppSearchWireframeProtocol!
    
    init(view: ItunesAppSearchViewProtocol, wireframe: ItunesAppSearchWireframeProtocol) {
        self.view = view
        self.wireframe = wireframe
    }
}


extension ItunesAppSearchInteractor: ItunesAppSearchInteractorInputProtocol {
    func onViewDidLoad() {
        
    }
    
    func searchApp(key: String) {
        
    }
}
