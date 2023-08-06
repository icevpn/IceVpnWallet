//
//  CustomButtonExtension.swift
//  ICE VPN
//
//  Created by HaydenYe on 2023/5/22.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    convenience init(image: String, target: Any?, action: Selector) {
        self.init(image: UIImage(named: image)?.withRenderingMode(.alwaysOriginal), style: .plain, target: target, action: action)
    }
}
