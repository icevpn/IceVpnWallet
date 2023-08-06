//
//  Account.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/17.
//

import UIKit
import HandyJSON
class Account : HandyJSON{
    var _id = String.randomString(length: 16)
    
    var name : String = "Wallet"
    
    var chainId : Int = 1
    
    var chain : Chain = Chain.ETH()
    
    var address : String = ""
    
    var cipheredMnemonics = ""
    
    var cipheredPrivateKey = ""
    
    var createDate : String = Date().systemNowDate()
    
    var tokens : [Token]?
    
    var nfts : [NFT]?
    
    var pathNum : Int = 0
    
    private var _mainToken : Token?
    
    private var _subTokens : [Token]?
    
    required init() {
        
    }
    
    static private var _currentAccount : Account?
    static var currentAccount : Account?{
        get{
            if (_currentAccount != nil){
                return _currentAccount
            }
            let json: String? = UserDefaults.standard.string(forKey: WalletCacheKey.kSaveCurrentAccount)
            guard let account = Account.deserialize(from: json) else{
                return nil
            }
            _currentAccount = account
            return _currentAccount
        }
        set{
            _currentAccount = newValue
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: WalletCacheKey.kSaveCurrentAccount)
                UserDefaults.standard.synchronize()
                return
            }
            if let json = _currentAccount?.toJSONString() {
                UserDefaults.standard.set(json, forKey: WalletCacheKey.kSaveCurrentAccount)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    static func loginOutAccount(){
        _currentAccount = nil
    }
}


extension Account{
    
    var mainToken : Token?{
        get{
            if (_mainToken != nil){
                return _mainToken
            }
            for token in (tokens ?? []){
                if (token.address == ""){
                    _mainToken = token
                    break
                }
            }
            return _mainToken
        }
    }
    
    
    var subTokens : [Token]{
        get{
            if (_subTokens != nil){
                return _subTokens!
            }
            _subTokens = []
            for token in (tokens ?? []){
                if (token.address == ""){
                    continue
                }
                _subTokens?.append(token)
            }
            return _subTokens!
        }
    }
}


extension Account{
    convenience init(mnemonic : String,chain:Chain = Chain.ETH()){
        self.init()
        self.chain = chain
        self.mnemonic = mnemonic
        let value = WalletManager.shared.createPrivateKey(mnemonics: mnemonic)
        self.privateKey = value.privateKey ?? ""
        self.address = value.address ?? ""
        self.tokens = self.getTokens()
    }
    
    convenience init(privateKey : String,chain:Chain = Chain.ETH()){
        self.init()
        self.chain = chain
        let address = WalletManager.shared.createAddress(privateKey: privateKey)
        self.privateKey = privateKey
        self.address = address ?? ""
        self.tokens = self.getTokens()
    }
    
    var mnemonic: String {
        get {
            return WalletCrypto.aes256Decrypt(value: cipheredMnemonics)
        }
        set {
            cipheredMnemonics = WalletCrypto.aes256Encrypt(value: newValue) ?? ""
        }
    }
    
    var privateKey: String{
        get {
            return WalletCrypto.aes256Decrypt(value: cipheredPrivateKey)
        }
        set {
            cipheredPrivateKey = WalletCrypto.aes256Encrypt(value: newValue) ?? ""
        }
    }
}

extension Account{
    func changeChain(_ chain : Chain){
        self.chain = chain
        self.chainId = chain.chainId
        _mainToken = nil
        _subTokens = nil
        self.tokens = self.getTokens()
    }
    
    func getNFTs() async{
        do{
            self.nfts = try await ContractAPI.getNFTList(account:self)
        }catch let error as WalletError{
            IVToast.toast(hit: error.errorDescription)
        }catch{
            IVToast.toast(hit: error.localizedDescription)
        }
    }
    
    private func getTokens() -> [Token]{
        let url = Bundle.main.url(forResource: "tokens", withExtension: "json")!
        let source = try! String(contentsOf: url)
        guard let arr = source.toDictionary()?["\(self.chain.chainId)"] as? [Any] else {
            return []
        }
        return [Token].deserialize(from: arr) as? [Token] ?? []
    }
    
    func getAllBalance() async {
        for token in self.tokens ?? []{
            await token.getBalance(account: self)
        }
        _mainToken = nil
        _subTokens = nil
    }
}
