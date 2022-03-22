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
        window.makeKeyAndVisible()
    }
    
    private func addTabViewControllers() {
        var tabViewContorllers = [UIViewController]()
        tabViewContorllers.append(TodayViewController())
        tabViewContorllers.append(GameViewController())
        tabViewContorllers.append(AppViewController())
        tabViewContorllers.append(UpdateViewController())
        tabViewContorllers.append(getITunesAppSearchViewController())

        self.view.setViewControllers(tabViewContorllers, animated: false)
    }
    
    private func getITunesAppSearchViewController() -> UIViewController {
        let itunesAppSearchWireframe = ItunesAppSearchWireframe()
        itunesAppSearchWireframe.setup()
        let navigationController = UINavigationController(rootViewController: itunesAppSearchWireframe.configuredViewController())
        return navigationController
    }
}
