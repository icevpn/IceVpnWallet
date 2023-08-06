//
//  IVManageModel.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/16.
//

import Foundation

enum ManageType{
    case none
    case arrow
}

enum ManageTagType{
    case name
    case address
    case mnemonic
    case privateKey
    case updatePassword
    case forgetPassword
}

struct IVManageModel {
    var title : String
    var content : String
    var type : ManageType
    var tag : ManageTagType
    init(title: String, content: String = "", type: ManageType = .none,tag : ManageTagType) {
        self.title = title
        self.content = content
        self.type = type
        self.tag = tag
    }
}
