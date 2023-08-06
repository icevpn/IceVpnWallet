//
//  IVWalletHeadItemModel.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/7.
//

import UIKit

struct IVWalletHeadItemModel {
    var icon : UIImage?
    var title : String
    var tag : Int
    init(icon: UIImage? = nil, title: String, tag: Int) {
        self.icon = icon
        self.title = title
        self.tag = tag
    }
}
