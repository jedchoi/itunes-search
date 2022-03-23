//
//  UITextView.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/24.
//

import Foundation
import UIKit

extension UITextView {
    var estimatedHeight: CGFloat {
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = self.sizeThatFits(size)
        Logger.track("estimatedSize \(estimatedSize)")
        return estimatedSize.height
    }
}
    
