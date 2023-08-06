//
//  AppConfig.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/30.
//

import UIKit
///获取服务端配置文件地址
let app_config_path = "https://static.icevpns.com/app/config/"

///更新Dapp
let kNotifyRefreshDappHistory = NSNotification.Name(rawValue: "kNotifyRefreshDappHistory")

//MARK: 尺寸
let Screen_width = UIScreen.main.bounds.size.width
let Screen_height = UIScreen.main.bounds.size.height


/// 安全区底部高度
var safeBottomH : CGFloat{
    let height:CGFloat = UIView.topWindow()?.safeAreaInsets.bottom ?? 0
    return height
}

var statusBarH : CGFloat{
    let height:CGFloat = UIView.topWindow()?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    return height
}

var fullNavigationBarH: CGFloat {
    let height = statusBarH + 44.0
    return height
}

var appVersion: String{
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "10.0.0"
}

