//
//  WalletUtil.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/18.
//

import UIKit
import KeychainAccess
import CryptoSwift

class WalletCrypto{
    static let keychain = Keychain(service: "xxxxx")
    class func getEncryptionKey() -> Data{
        if let deviceId = try? keychain.getData("xxxxxxxxxxxxxxxx") { return deviceId }
        var uuid = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        if (uuid.count > 32){
            uuid = "\(uuid.prefix(32))"
        }
        if (uuid.count < 32){
            while uuid.count < 32 {
                uuid = uuid + "x"
            }
        }
        let uuidData = uuid.data(using: .utf8)!
        try? keychain.set(uuidData, key: "xxxxxxxxxxxxxxxx")
        return uuidData
    }
    
    @discardableResult
    class func aes256Encrypt(value:String) -> String?{
        guard let data = (value.data(using: .utf8) as? NSData) else{
            return nil
        }
        guard let result = data.aes256Encrypt(withKey: WalletCrypto.getEncryptionKey(), iv: nil) else{
            return nil
        }
        let result2 = (result as NSData).aes256Encrypt(withKey: WalletCrypto.getEncryptionKey(), iv: nil)!
        return result2.base64EncodedString()
    }
    
    class func aes256Decrypt(value:String) -> String{
        let data = Data(base64Encoded: value) as NSData?
        guard let data1 = data?.aes256DecryptWithkey(WalletCrypto.getEncryptionKey(), iv: nil) else {return ""}
        guard let data2 = (data1 as NSData).aes256DecryptWithkey(WalletCrypto.getEncryptionKey(), iv: nil) else {return ""}
        return String(data: data2, encoding: .utf8) ?? ""
    }
    
    class func md5Encrypt(value:String) -> String?{
        guard let data = value.data(using: .utf8)  else{
            return nil
        }
        return data.md5().toHexString()
    }
}
