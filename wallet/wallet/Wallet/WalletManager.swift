//
//  WalletManager.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/18.
//

import UIKit
import web3swift
import Web3Core

let kMenmonics = "kMenmonics"
let kWalletPassword = "kWalletPassword"

class WalletManager{
    static let shared = WalletManager()
    //钱包密码 md5加密 不需要知道具体值 拿来直接比较就行
    var password : String?{
        get{
            let value = UserDefaults.standard.value(forKey: kWalletPassword)
            return value as? String
        }
        set{
            guard let password = newValue else{
                return
            }
            guard let result = WalletCrypto.md5Encrypt(value: password) else{
                return
            }
            UserDefaults.standard.setValue(result, forKey: kWalletPassword)
            UserDefaults.standard.synchronize()
        }
    }
    
    ///生成随机助记词
    func getCreateMnemonics(index:Int = 0) -> [String]{
        guard let mnemonics = try? BIP39.generateMnemonics(bitsOfEntropy: 128, language: .english) else {
            //助记词生成失败
            if index < 3 {
                ///失败后再多尝试两次
                return getCreateMnemonics(index: index+1)
            }
            return []
        }
        return mnemonics.components(separatedBy: " ")
    }
    
    ///验证助记词
    func checkMnemonics( mnemonics:inout String) -> Bool {
        mnemonics = mnemonics.trimmingCharacters(in: .whitespaces)
        let dealTexts = mnemonics.components(separatedBy: " ").filter{
            $0 != ""
        }
        guard dealTexts.count == 12 else {
            return false
        }
        if (self.createPrivateKey(mnemonics: mnemonics).privateKey == nil){
            return false
        }
        return true
    }
    
    ///使用助记词生成私钥和地址
    func createPrivateKey(mnemonics : String) -> (privateKey : String?,address : String?){
        guard let ks = self.getKeystore(mnemonics) else{
            return (nil,nil)
        }
        let account = ks.addresses![0]
        guard let key = try? ks.UNSAFE_getPrivateKeyData(password: "", account: account) else{
            return (nil,nil)
        }
        return (key.toHexString(),account.address)
    }
    
    ///使用私钥生成地址
    func createAddress(privateKey : String) -> String?{
        guard let keystore = try! EthereumKeystoreV3(privateKey: Data(hex: privateKey),password: "")else{
            return nil
        }
        return keystore.addresses?.first?.address
    }
    
    private func getKeystore(_ mnemonics : String) -> BIP32Keystore?{
        guard let ks = try? BIP32Keystore(mnemonics: mnemonics, password: "", language: .english,prefixPath: "m/44'/60'/0'/0") else{
            return nil
        }
        return ks
    }
}


