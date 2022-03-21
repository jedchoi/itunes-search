//
//  UIImageView.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/21.
//

import Foundation
import UIKit

extension UIImageView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func load(from url: String) {
        guard let url = URL(string: url) else {
            Logger.track("URL convert error")
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) else {
                Logger.track("image get error")
                return
            }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
