//
//  RootWireFrame.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/20.
//

import UIKit

protocol TabBarInterface {
    func configuredViewController() -> UIViewController
}

protocol MainTabHomeWireframeProtocol: AnyObject {
    // Presenter -> Wireframe
}

final class MainTabHomeWireframe: MainTabHomeWireframeProtocol {
    var view: UITabBarController!
    var mainWindow: UIWindow?

    var tabBarWireframes: [TabBarInterface]

    init() {
        tabBarWireframes = [TabBarInterface]()
    }
    
    func setup() {
        let view = MainTabHomeViewController()
        let interactor = MainTabHomeInteractor(view: view, wireframe: self)
        view.interactor = interactor
        self.view = view
        
        addTabViewControllers()
    }
    
    func present(fromWindow window: UIWindow) {
        window.rootViewController = view

        mainWindow = window
    }
    
    private func addTabViewControllers() {
        let itunesAppSearchWireframe = ItunesAppSearchWireframe()
        itunesAppSearchWireframe.setup()
        tabBarWireframes.append(TodayViewController())
        tabBarWireframes.append(GameViewController())
        tabBarWireframes.append(AppViewController())
        tabBarWireframes.append(UpdateViewController())
        tabBarWireframes.append(itunesAppSearchWireframe)
        
        var tabViewContorllers = [UIViewController]()
        for wireFrame in tabBarWireframes {
            tabViewContorllers.append(wireFrame.configuredViewController())
        }
        self.view.setViewControllers(tabViewContorllers, animated: false)
    }
}
