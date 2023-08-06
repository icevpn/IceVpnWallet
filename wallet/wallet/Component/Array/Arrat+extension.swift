//
//  Arrat+extension.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/12.
//

import Foundation
extension Array{
    func getRandomAry() -> [Any] {
        var netItems = self
        let count = self.count
        for i in 1..<count {
            let index = Int(arc4random()) % i
//            dPrint("=======index====\(index)=======")
            if index != i {
                netItems.swapAt(i, index)
            }
        }
        return netItems
    }
}
