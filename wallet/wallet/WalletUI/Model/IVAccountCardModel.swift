//
//  IVAccountCardModel.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/14.
//

import UIKit

struct IVAccountCardModel {
    var name : String
    var num : Int
    var first : String{
        get{
            if (name.count == 0){
                return ""
            }
            return name.prefix(1) + ""
        }
    }
    init(name: String, num: Int) {
        self.name = name
        self.num = num
    }
}
