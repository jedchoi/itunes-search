//
//  RootViewController.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/20.
//

import UIKit

protocol MainTabHomeViewProtocol: AnyObject {
    // Interactor -> View
}

final class MainTabHomeViewController: UITabBarController {
    var interactor: MainTabHomeInteractorInputProtocol!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBarItem()
    }
}

extension MainTabHomeViewController: MainTabHomeViewProtocol {
    
}

private extension MainTabHomeViewController {
    func configureTabBarItem() {
        guard let tabViewControllers = viewControllers else { return }

        let items = [
            UITabBarItem(tabBarSystemItem: .favorites, tag: 1),
            UITabBarItem(tabBarSystemItem: .featured, tag: 2),
            UITabBarItem(tabBarSystemItem: .topRated, tag: 3),
            UITabBarItem(tabBarSystemItem: .bookmarks, tag: 4),
            UITabBarItem(tabBarSystemItem: .search, tag: 5)
        ]

        (0 ..< tabViewControllers.count).forEach { tabViewControllers[$0].tabBarItem = items[$0] }
    }
}
