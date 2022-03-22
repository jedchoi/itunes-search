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
        lockOrientation(.portrait)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBarItem()
        self.selectedIndex = 4
    }
}

extension MainTabHomeViewController: MainTabHomeViewProtocol {
    
}

private extension MainTabHomeViewController {
    func configureTabBarItem() {
        guard let tabViewControllers = viewControllers else { return }

        let items = [
            UITabBarItem(title: "투데이", image: UIImage.init(systemName: "doc.text.fill"), tag: 1),
            UITabBarItem(title: "게임", image: UIImage.init(systemName: "gamecontroller.fill"), tag: 2),
            UITabBarItem(title: "앱", image: UIImage.init(systemName: "square.stack.3d.up.fill"), tag: 3),
            UITabBarItem(title: "업데이트", image: UIImage.init(systemName: "square.and.arrow.down.fill"), tag: 4),
            UITabBarItem(title: "검색", image: UIImage.init(systemName: "magnifyingglass"), tag: 5)
        ]

        (0 ..< tabViewControllers.count).forEach { tabViewControllers[$0].tabBarItem = items[$0] }
    }
}
