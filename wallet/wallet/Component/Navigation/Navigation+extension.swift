//
//  Navigation+extension.swift
//  ICE VPN
//
//  Created by HaydenYe on 2023/6/6.
//

import Foundation
import UIKit

protocol HideNavigationBarProtocol where Self: UIViewController {}

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
}

/// Hide navigation bar
extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
            if (viewController is HideNavigationBarProtocol){
                self.setNavigationBarHidden(true, animated: true)
            }else {
                self.setNavigationBarHidden(false, animated: true)
            }
        }
}
