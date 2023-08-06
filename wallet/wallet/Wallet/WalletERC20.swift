//
//  WalletERC20.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/22.
//

import UIKit
import web3swift
import Web3Core
import BigInt

public typealias TransactionSuccessStringClosure = (_ string: String) -> Void
public typealias TransactionFailedClosure = (_ errorMsg: String) -> Void

struct checkRPCVisableRequest : WalletERCRequest{
    var account: Account
    func request() async -> Bool{
        return ((try?(await self.fetchAwait(.blockNumber) as? Bool) ?? false) ?? false)
    }
}

struct nonceRequest : WalletERCRequest{
    var account: Account
    func request() async -> BigUInt?{
        return try?(await self.fetchAwait(.getTransactionCount(account.address, .latest)) as? BigUInt)
    }
}

struct gasRequest : WalletERCRequest{
    var account: Account
    func request() async -> BigUInt?{
        return try?(await self.fetchAwait(.gasPrice) as? BigUInt)
    }
}

///预估主网gaslimit 目前只有arb需要
struct getGasLimitRequest : WalletERCRequest{
    var account: Account
    var transaction : CodableTransaction
    func request() async -> BigUInt?{
        return try?(await self.fetchAwait(.estimateGas(transaction, .latest)) as? BigUInt)
    }
}


///预估主网gaslimit 目前只有arb需要
struct getMainGasRequest : WalletERCRequest{
    var account: Account
    var transnum : String
    var to : String
    var gasPrice : BigUInt
    var decimal : Int = 18
    func request() async -> BigUInt?{
        guard let tansaction = self.createTransaction(transnum: transnum, decimal: decimal, gasPrice: gasPrice, fromAddress: account.address, toAddress: to, chainId: account.chain.chainId) else{
            return nil
        }
        return await getGasLimitRequest(account: account, transaction: tansaction).request()
    }
}

///预估代币转账GasLimit
struct getTokenGasLimtRequest : WalletERCRequest{
    var account: Account
    var transnum : String
    var to : String
    var gasPrice : BigUInt
    var token : Token
    func request() async throws -> BigUInt?{
        guard let fromAddress = EthereumAddress(account.address) else{
            return nil
        }
        guard let toAddress = EthereumAddress(to) else{
            return nil
        }
        guard let eAddress = EthereumAddress(token.address) else {
            throw WalletError.addressError(desc: "token address Error")
        }
        let web = try await createWeb3(account: account)
        guard let finalTransaction = self.createTransaction(transnum: "0", decimal: token.decimals, gasPrice: gasPrice, fromAddress: account.address, toAddress: to, chainId: account.chain.chainId) else{
            throw WalletError.inputError(desc: "tx error")
        }
        let erc20token = ERC20.init(web3: web, provider:web.provider, address: eAddress,transaction: finalTransaction)
        let transaction = try await erc20token.transfer(from: fromAddress, to: toAddress, amount: transnum)
        return await getGasLimitRequest(account: account, transaction: transaction.transaction).request()
    }
}

struct getBalanceRequest : WalletERCRequest{
    var account: Account
    var contractAddress : String
    func request() async throws -> BigUInt?{
        if contractAddress.count == 0 {
            return try await self.fetchAwait(.getBalance(account.address, .latest)) as? BigUInt
        }
        let web = try await createWeb3(account: account)
        guard let walletAddress = EthereumAddress(account.address) else {
            throw WalletError.addressError(desc: "address Error")
        }
        guard let eAddress = EthereumAddress(contractAddress) else {
            throw WalletError.addressError(desc: "token Error")
        }
        let erc20token = ERC20.init(web3: web, provider:web.provider, address: eAddress)
        return try await erc20token.getBalance(account: walletAddress)
    }
}

struct transferRequest : WalletERCRequest{
    var account: Account
    var to : String
    var token : Token
    var num : String
    var gas : IVGasModel
    func request() async throws -> TransactionSendingResult{
        guard let gasPrice = await gasRequest(account: account).request() else{
            throw WalletError.gasError(desc: nil)
        }
        guard let from = EthereumAddress(account.address) else{
            throw WalletError.addressError(desc: nil)
        }
        guard var finalTransaction = self.createTransaction(transnum: num, decimal: token.decimals, gasPrice: gasPrice, fromAddress: account.address, toAddress: to, chainId: account.chain.chainId) else{
            throw WalletError.inputError(desc: "tx error")
        }
        finalTransaction.gasPrice = gasPrice
        let gasLimit = gas.gasLimit.toInt()
        finalTransaction.gasLimit = BigUInt(gasLimit)
        guard let nonce = await nonceRequest(account: account).request() else{
            throw WalletError.addressError(desc: nil)
        }
        finalTransaction.nonce = nonce
        
        if token.address.count != 0 {
            return try await contractTransferRequest(account: account, transaction: finalTransaction, tokenAddress: token.address).request()
        }
        let web = try await createWeb3(account: account)
        let privateKey = Data(hex: account.privateKey.add0x)
        try finalTransaction.sign(privateKey: privateKey)
        return try await web.eth.send(raw: finalTransaction.encode()!)
    }
}

struct contractTransferRequest : WalletERCRequest{
    var account: Account
    var transaction : CodableTransaction
    var tokenAddress : String
    func request() async throws -> TransactionSendingResult{
        guard let eAddress = EthereumAddress(tokenAddress) else{
            throw WalletError.addressError(desc: nil)
        }
        let web = try await createWeb3(account: account)
        let erc20token = ERC20.init(web3: web, provider:web.provider, address: eAddress,transaction: transaction)
        guard let writeTX = try? await erc20token.transfer(from: transaction.from!, to: transaction.to, amount: "0" ) else {
            throw WalletError.inputError(desc: "tx error")
        }
        let gasLimit = try await web.eth.estimateGas(for: writeTX.transaction)
        writeTX.transaction.gasLimit = gasLimit
        let privateKey = Data(hex: account.privateKey.add0x)
        try writeTX.transaction.sign(privateKey: privateKey)
        return try await web.eth.send(raw: writeTX.transaction.encode()!)
    }
}

class WalletERC20 : IVJSONProtocol{
    //合约调用
    class func contractDataTransferRequest(account: Account,
                                           data: [String: Any]) async throws -> TransactionSendingResult?{
        guard let web = try? await createWeb3(account: account) else{
            throw WalletError.rpcError(desc: nil)
        }
        guard let gasPrice = await gasRequest(account: account).request() else{
            throw WalletError.gasError(desc: nil)
        }
        var finalTransaction = try createCodableTransaction(data)
        finalTransaction.gasPrice = gasPrice
        finalTransaction.chainID = BigUInt(account.chain.chainId)
        guard let from = EthereumAddress(account.address) else{
            throw WalletError.addressError(desc: nil)
        }
        finalTransaction.from = from
        guard let nonce = try? await web.eth.getTransactionCount(for: from) else{
            throw WalletError.rpcError(desc: nil)
        }
        finalTransaction.nonce = nonce
        
        if finalTransaction.gasLimit == 0{
            finalTransaction.gasLimit =  await getGasLimitRequest(account: account, transaction: finalTransaction).request() ?? BigUInt(0)
        }
        
        let privateKey = Data(hex: account.privateKey.add0x)
        try finalTransaction.sign(privateKey: privateKey)
        return try await web.eth.send(raw: finalTransaction.encode()!)
    }
    
    //获取合约调用的gasLimit
    class func getContractDataGasLimitRequest(account: Account,
                                           data: [String: Any]) async throws -> BigUInt{
        guard let web = try? await createWeb3(account: account) else{
            throw WalletError.rpcError(desc: nil)
        }
        guard let gasPrice = await gasRequest(account: account).request() else{
            throw WalletError.gasError(desc: nil)
        }
        var finalTransaction = try createCodableTransaction(data)
        finalTransaction.gasPrice = gasPrice
        finalTransaction.chainID = BigUInt(account.chain.chainId)
        guard let from = EthereumAddress(account.address) else{
            throw WalletError.addressError(desc: nil)
        }
        finalTransaction.from = from
        guard let nonce = try? await web.eth.getTransactionCount(for: from) else{
            throw WalletError.rpcError(desc: nil)
        }
        finalTransaction.nonce = nonce
        return await getGasLimitRequest(account: account, transaction: finalTransaction).request() ?? BigUInt(0)
    }
    
    
    class func createWeb3(account:Account) async throws -> Web3{
        guard let we3P = try? await Web3HttpProvider(url:URL(string: account.chain.currentRPC)!,network: Networks.Custom(networkID: BigUInt(account.chain.chainId))) else {
            throw WalletError.rpcError(desc: nil)
        }
        let web = Web3(provider: we3P)
        return web
    }
    
    class func createCodableTransaction(_ data : [String : Any]) throws ->  CodableTransaction{
        guard let toAddress = data["to"] as? String, let to = EthereumAddress(toAddress)  else{
            throw WalletError.inputError(desc: "to address error")
        }
        
        guard let dataValue = data["data"] as? String else{
            throw WalletError.addressError(desc: nil)
        }
        
        var value = BigUInt(0)
        if let dataValue = data["value"] as? String, let amount = BigUInt(dataValue.removeString("0x"),radix: 16) {
            value = amount
        }
        var transaction: CodableTransaction = .emptyTransaction
        transaction.to = to
        if let gasLimit = data["gas"] as? String , let gas = BigUInt(gasLimit.removeString("0x"),radix: 16){
            transaction.gasLimit = gas
        }
        transaction.data = Data(hex:dataValue.add0x)
        transaction.value = value
        return transaction
    }
}
