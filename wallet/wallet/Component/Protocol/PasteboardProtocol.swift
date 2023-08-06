//
//  PasteboardProtocol.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/8.
//

import Foundation


protocol PasteboardProtocol {
    func pastWord(str: String)
}

extension PasteboardProtocol{
    func pastWord(str: String){
        let pasteboard = UIPasteboard(name: .general, create: true)
        pasteboard?.string = str
        IVToast.toast(hit: "Copy success!")
    }
}
