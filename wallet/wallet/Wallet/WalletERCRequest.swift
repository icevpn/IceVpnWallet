//
//  WalletERCRequest.swift
//  ICE VPN
//
//  Created by tgg on 2023/7/17.
//

import Foundation
import web3swift
import Web3Core
import BigInt
protocol WalletERCRequest {
    /// API URL address
    var account: Account { get }
}

extension WalletERCRequest {
    func fetchAwait(_ apiRequest: APIRequest) async throws -> Any {
        guard let web = try? await createWeb3(account: account) else{
            throw WalletError.rpcError(desc: nil)
        }
        let response: APIResponse<BigUInt> = try await APIRequest.sendRequest(with: web.provider, for: apiRequest)
        return response.result
    }
    
    func createWeb3(account:Account) async throws -> Web3{
        guard let we3P = try? await Web3HttpProvider(url:URL(string: account.chain.currentRPC)!,network: Networks.Custom(networkID: BigUInt(account.chain.chainId))) else {
            throw WalletError.rpcError(desc: nil)
        }
        let web = Web3(provider: we3P)
        return web
    }
    
    func createTransaction(transnum:String,decimal : Int,gasPrice : BigUInt ,fromAddress : String,toAddress : String,chainId : Int) -> CodableTransaction?{
        guard let amount = Utilities.parseToBigUInt(transnum, decimals: decimal) else {return nil}
        guard let from = EthereumAddress(fromAddress) else{return nil}
        guard let to = EthereumAddress(toAddress) else{return nil}
        var transaction: CodableTransaction = .emptyTransaction
        transaction.from = from
        transaction.to = to
        transaction.gasPrice = gasPrice
        transaction.value = amount
        transaction.chainID = BigUInt(chainId)
        return transaction
    }
}
