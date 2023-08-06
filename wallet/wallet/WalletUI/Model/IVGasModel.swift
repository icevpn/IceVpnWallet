//
//  IVGasModel.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/15.
//

import UIKit

class IVGasModel : NSObject{
    private var gasPrice : String = ""
    var gasLimit : String = ""
    ///默认选中快速
    var index = 1
    
    convenience init(gasPrice: String,gasLimit : String = "") {
        self.init()
        self.gasPrice = gasPrice
        if (gasLimit != ""){
            self.gasLimit = gasLimit
        }
        
    }
    
    var gas : String{
        let gas = gasPrice.take(numberString: gasLimit).division(numberString: BaseGasFee)
        return gas
    }
    
    var use_gasPrice : String{
        get{
            var gasPrice = self.getMinersPrice(index)
            return gasPrice
        }
    }
    
    ///计算矿工费 index 0最快，1快速，2一般
    func getMinersPrice(_ index : Int) -> String {
        if (index == 0){
            return gasPrice.take(numberString: "1.2")
        }
        if (index == 1){
            return gasPrice
        }
        return gasPrice.take(numberString: "0.9")
    }
}


