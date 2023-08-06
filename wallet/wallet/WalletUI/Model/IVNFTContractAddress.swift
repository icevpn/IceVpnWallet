//
//  IVNFTContract.swift
//  ICE VPN
//
//  Created by tgg on 2023/7/6.
//

import Foundation
import HandyJSON
struct IVNFTContract : HandyJSON{
    var ETH : String = ""
    var BSC : String = ""
    var ARB : String = ""
    var Polygon : String = ""
    
    func getContract(_ chainId : Int) -> String{
        if chainId == 1{
            return ETH
        }
        if chainId == 56{
            return BSC
        }
        if chainId == 42161{
            return ARB
        }
        if chainId == 137{
            return Polygon
        }
        return ETH
    }
    
}
