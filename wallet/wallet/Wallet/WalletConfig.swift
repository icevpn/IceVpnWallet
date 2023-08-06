//
//  WalletConfig.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/30.
//  用于获取配置的类

import Foundation

class WalletConfig {
    static let shared = WalletConfig()
    var chains : [Chain]?
    var nfts : [Token]?
    class func getConfig(){
        WalletConfig.shared.getChains()
    }
}

extension WalletConfig{
    @discardableResult
    func getChains() -> [Chain]{
        if (chains != nil){
            return chains!
        }
        let url = Bundle.main.url(forResource: "chain", withExtension: "json")!
        let source = try! String(contentsOf: url)
        guard let arr = source.toArray() else {
            return []
        }
        self.chains = [Chain].deserialize(from: arr) as? [Chain]
        return self.chains ?? []
    }
    ///判断是否包含某个链
    func hasChain(_ chainid : Int) -> Bool{
        var result = false
        self.getChains().forEach({ chain in
            if (chain.chainId == chainid){
                result = true
            }
        })
        return result
    }
    
    func getChain(_ chainid : Int) -> Chain?{
        for chain in self.getChains(){
            if (chain.chainId == chainid){
                return chain
            }
        }
        return nil
    }
}
