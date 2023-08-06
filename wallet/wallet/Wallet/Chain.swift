//
//  Chain.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/17.
//

import UIKit
import HandyJSON

let BaseGasFee = "1000000000000000000"

class Chain : HandyJSON{
    var chainId : Int = 0
    
    var chainName : String = ""
    
    var chainSymbol : String = ""
    
    var browser : String = ""
    
    var rpc : [RPC] = []
    
    var api : String = ""
    
    var apiKey : String = ""
    
    var icon : String = ""
    
    var currentRPC : String = ""
    
    init(chainId:Int,chainName:String,chainSymbol:String,icon:String,rpc:String,browser:String,api:String) {
        self.chainId = chainId
        self.icon = icon
        self.browser = browser
        self.chainName = chainName
        self.chainSymbol = chainSymbol
        self.currentRPC = rpc
        self.api = api
    }
    
    required init() {
        
    }
}

extension Chain{
    static func ETH() -> Chain{
        return Chain(chainId: 1, chainName: "Ethereum", chainSymbol: "Ethereum", icon: "https://raw.githubusercontent.com/icevpn/ice-vpn-tokens/main/ETH.png", rpc: "https://rpc.ankr.com/eth", browser: "https://cn.etherscan.com", api: "https://api.etherscan.io/api")
    }
}

extension Chain{
    static func saveCurrentChain(chain : Chain){
        if let json = chain.toJSONString() {
            UserDefaults.standard.set(json, forKey: WalletCacheKey.kSaveCurrentChain)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func getCurrentChain() -> Chain{
        let json: String? = UserDefaults.standard.string(forKey: WalletCacheKey.kSaveCurrentChain)
        guard let chain = Chain.deserialize(from: json) else{
            return Chain.ETH()
        }
        return chain
    }
}
