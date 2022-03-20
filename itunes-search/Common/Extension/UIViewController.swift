//
//  UIViewController.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/20.
//

import Foundation
import UIKit

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(_ storyboard: Storyboard) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
}


enum Storyboard: String {
    case ItunesAppSearch
    case ItunesAppDetail
}

extension Storyboard {
    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID

        guard let viewContorller = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(rawValue) Storyboard")
        }

        return viewContorller
    }
}
