//
//  Thread+extension.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/9.
//

import UIKit


extension Thread {
    
    static func safe_main(_ block: @escaping ()->Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
