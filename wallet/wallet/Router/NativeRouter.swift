//
//  NativeRouter.swift
//  ICE VPN
//
//  Created by HaydenYe on 2023/6/5.
//

import UIKit
import GetRouter

struct RouterNativeHandler: GetRouterHandlerSource {
    var pages: [GetPage] = [
        /// wallet module
        GetPage(name: .recive,
                action: { _ in
                    UIUtil.visibleNav()?.pushViewController(IVReceiveVC(), animated: true)
                }
        ),
        GetPage(name: .sendTo,
                action: { params in
                    let vc = IVWalletSendVC()
                    if let model = params?["token"] as? Token {
                        vc.selectToken = model
                    }
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .selectToken,
                action: { _ in
                    let vc = IVWalletSelectTokenVC()
                    UIUtil.visibleNav()?.present(vc, animated: true)
                }
        ),
        GetPage(name: .walletMain,
                action: { _ in
                    let vc = IVWalletVC()
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .transfer,
                action: { _ in
                    UIUtil.visibleNav()?.pushViewController(IVWalletTransferVC(), animated: true)
                }
        ),
        GetPage(name: .walletCreate,
                action: { _ in
                    UIUtil.visibleNav()?.pushViewController(IVWalletCreateVC(), animated: true)
                }
        ),
        GetPage(name: .walletMnemonic,
                action: { params in
                    let vc = IVWalletMnemonicVC()
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .walletBackup,
                action: { params in
                    let vc = IVWalletBackupVC()
                    vc.walletName = params?["name"] as? String
                    vc.mnemonics = params?["mnemonics"] as? [String] ?? []
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .walletPassword,
                action: { params in
                    let vc = IVPasswordVC()
                    vc.account = params?["account"] as? Account
                    vc.isCreate = (params?["isCreate"] as? Bool) ?? false
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .walletImport,
                action: { params in
                    UIUtil.visibleNav()?.pushViewController(IVWalletImportVC(), animated: true)
                }
        ),
        GetPage(name: .scan,
                action: { params in
                    let vc = IVScanVC()
                    vc.delegate = params?["vc"] as? any IVScanDelegate
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .walletChain,
                action: { params in
                    let vc = IVWalletChainVC()
                    vc.delegate = params?["vc"] as? any IVWalletChainDelegate
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .walletSetting,
                action: { params in
                    let vc = IVWalletSettingVC()
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .walletUpdatePassword,
                action: { params in
                    let vc = IVUpdatePasswordVC()
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .walletForgetPassword,
                action: { params in
                    let vc = IVForgetPasswordVC()
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .walletExport,
                action: { params in
                    let vc = IVExportMnemonicVC()
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .tokenDetail,
                action: { params in
                    let vc = IVTokenDetailVC()
                    vc.token = params?["token"] as? Token
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                }
        ),
        GetPage(name: .exportPrivateKey,
                action: { params in
                    let vc = IVExportPrivateKeyVC()
                    UIUtil.visibleNav()?.pushViewController(vc, animated: true)
                    
                }
        ),
        
        
    ]
}
