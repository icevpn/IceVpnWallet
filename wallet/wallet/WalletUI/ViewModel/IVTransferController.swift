//
//  IVTransferController.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/15.
//

import UIKit

struct IVTransferController{
    static func getGas(token : Token,toAddress : String,num:String = "1") async throws -> IVGasModel{
        guard let account = Account.currentAccount else{
            throw WalletError.inputError(desc: "Wallet error")
        }
        guard let gasPrice = await gasRequest(account: account).request() else{
            throw WalletError.inputError(desc: "rpc error")
        }
        var gasLimit = "21000"
        if (account.chain.chainId == 42161 && token.address == ""){
            //ARB
            guard let limit = await getMainGasRequest(account: account, transnum: num, to: toAddress, gasPrice: gasPrice).request() else{
                throw WalletError.inputError(desc: "gas error")
            }
            gasLimit = "\(limit)"
        }
        if token.address != ""{
            guard let limit = try await getTokenGasLimtRequest(account: account, transnum: num, to: toAddress, gasPrice: gasPrice, token: token).request() else{
                throw WalletError.inputError(desc: "gas error")
            }
            gasLimit = "\(limit)"
        }
        return IVGasModel(gasPrice: "\(gasPrice)", gasLimit: gasLimit)
    }
    
    ///转账 返回交易hash 为空就说明失败了
    static func send(toAddress:String,num:String,token:Token) async throws -> String?{
        guard let account = Account.currentAccount else{
            return nil
        }
        let gas = try await getGas(token: token, toAddress: toAddress,num: num)
        let result = await token.getBalance(account: account)
        if (!result){
            throw WalletError.inputError(desc: "PRC error!")
        }
        if (token.balance.toDouble()<num.toDouble()){
            throw WalletError.inputError(desc: "Insufficient balance!")
        }
        let transferResult = try await transferRequest(account: account, to: toAddress, token: token, num: num, gas: gas).request()
        return transferResult.hash
    }
}
