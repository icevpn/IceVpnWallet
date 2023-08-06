//
//  IVToast.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/13.
//

import UIKit
import JFPopup
struct IVToast {
    static func toast(hit: String){
        JFPopupView.popup.toast(hit: hit)
    }
    
    static func toast(hit: String,icon: JFToastAssetIconType){
        JFPopupView.popup.toast(hit: hit,icon: icon)
    }
    
    static func toast(hit: String , icon : String){
        JFPopupView.popup.toast(hit: hit,icon: .imageName(name: icon))
    }
    
    static func loding(){
        JFPopupView.popup.loading()
    }
    
    static func hideLoding(){
        JFPopupView.popup.hideLoading()
    }
}
