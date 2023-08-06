//
//  NFT.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/5.
//

import Foundation
import BigInt
import Web3Core
class NFT {
    var tokenId : Int = 0
    var name = ""
    var symbol = ""
    var logo = ""
    var address = ""
    var balance = ""
    var decimals : Int = 0
    var chainId : Int = 0
    
    convenience init(tokenId : Int = 0,name : String = "",symbol:String = "",logo:String,address : String,decimals:Int = 1,chainId:Int){
        self.init()
        self.tokenId = tokenId
        self.name = name
        self.symbol = symbol
        self.logo = logo
        self.decimals = decimals
        self.chainId = chainId
        self.address = address
    }
}

extension NFT{
        
    
}
