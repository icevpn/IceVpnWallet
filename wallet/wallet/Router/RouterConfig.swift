//
//  RouterConfig.swift
//  ICE VPN
//
//  Created by HaydenYe on 2023/6/5.
//

import Foundation
import GetRouter

struct IVRouter {
    static func routerConfiguration() {
        GetRouter.config(nativeScheme: "ice", routeNameKey: "path")
        GetRouter.registerHandler(RouterNativeHandler())
        GetRouter.registerHandler(RouterWebHandler())
    }
    
    static func to(name: GetRouterName,
                   params: GetDict? = nil) {
        GetRouter.to(name: name, params: params)
    }
    
    static func to(url: String?,
                   params: GetDict? = nil) {
        GetRouter.to(url: url, params: params)
    }
}

extension GetRouterName {
    /// mine module
    static let mine: GetRouterName = "/native/mine"
    static let profile: GetRouterName = "/native/profile"
    static let setName: GetRouterName = "/native/setName"
    static let setPwd: GetRouterName = "/native/setPwd"
    static let language: GetRouterName = "/native/language"
    static let term: GetRouterName = "/native/term"
    static let privacy: GetRouterName = "/native/privacy"
    static let help: GetRouterName = "/native/help"
    static let reward: GetRouterName = "/native/reward"
    static let bind: GetRouterName = "/native/bind"
    
    /// vpn module
    static let vpn: GetRouterName = "/native/vpn"
    static let endPoint: GetRouterName = "/native/endPoint"
    static let endPointDetail: GetRouterName = "/native/endPointDetail"
    static let upgrade: GetRouterName = "/native/upgrade"
    static let upgraded: GetRouterName = "/native/upgraded"
    
    /// login module
    static let login: GetRouterName = "/native/login"
    static let register: GetRouterName = "/native/register"
    static let forget: GetRouterName = "/native/forget"
    static let otp: GetRouterName = "/native/otp"
    static let resetPw: GetRouterName = "/native/resetPw"

    /// wallet module
    static let recive : GetRouterName = "/native/recive"
    static let sendTo : GetRouterName = "/native/sendTo"
    static let selectToken : GetRouterName = "/native/selectToken"
    static let walletMain : GetRouterName = "/native/walletMain"
    static let transfer : GetRouterName = "/native/transfer"
    static let walletCreate : GetRouterName = "/native/walletCreate"
    static let walletMnemonic : GetRouterName = "/native/walletMnemonic"
    static let walletBackup : GetRouterName = "/native/walletBackup"
    static let walletPassword : GetRouterName = "/native/walletPassword"
    static let walletImport : GetRouterName = "/native/walletImport"
    static let scan : GetRouterName = "/native/scan"
    static let walletChain : GetRouterName = "/native/walletChain"
    static let walletSetting : GetRouterName = "/native/walletSetting"
    static let walletUpdatePassword : GetRouterName = "/native/walletUpdatePassword"
    static let walletForgetPassword : GetRouterName = "/native/walletForgetPassword"
    static let walletExport : GetRouterName = "/native/walletExport"
    static let tokenDetail : GetRouterName = "/native/tokenDetail"
    static let exportPrivateKey : GetRouterName = "/native/exportPrivateKey"
    /// dapp module
    static let dappList: GetRouterName = "/native/dappList"
    static let dappSearch: GetRouterName = "/native/dappSearch"
    
}
