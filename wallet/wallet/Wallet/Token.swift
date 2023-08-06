//
//  Token.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/20.
//

import UIKit
import HandyJSON
import Web3Core
import BigInt
class Token : HandyJSON{
    
    var name = ""
    var symbol = ""
    var logo = ""
    var balance = "0.0"
    var decimals : Int = 0
    var address = ""
    var chainId : Int = 0
    var gameWallet : Bool = false
    
    convenience init(name : String,symbol:String,logo:String,decimals:Int,address:String,chainId:Int,gameWallet:Bool = false){
        self.init()
        self.name = name
        self.symbol = symbol
        self.logo = logo
        self.decimals = decimals
        self.address = address
        self.chainId = chainId
        self.gameWallet = gameWallet
    }
    
    required init() {
        
    }
}

extension Token{
    ///获取token余额
    @discardableResult
    func getBalance(account:Account) async -> Bool {
        do{
            let balance = try await getBalanceRequest(account: account, contractAddress: self.address).request()
            self.balance = Utilities.formatToPrecision(balance ?? BigUInt(0),units: .custom(decimals))
            return true
        }catch{
            return false
        }
    }
}
