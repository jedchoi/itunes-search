//
//  UIImageView.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/21.
//

import Foundation
import UIKit
import Kingfisher

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
        self.kf.setImage(with: url)
    }
}
