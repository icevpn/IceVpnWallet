//
//  ContractAPI.swift
//  ICE VPN
//
//  Created by tgg on 2023/7/4.
//

import Foundation
import BigInt
import web3swift
import Web3Core


class ContractAPI: NSObject {
    class func getBalance(_ owner : EthereumAddress,nftContract : EthereumAddress,web:Web3) async throws -> BigUInt{
        let erc721 = ERC721.init(web3: web, provider:web.provider, address: nftContract)
        return try await erc721.getBalance(account: owner)
    }
    
    class func getTokenId(_ owner : EthereumAddress,nftContract : EthereumAddress,web:Web3,index:BigUInt) async throws -> BigUInt{
        let erc721 = ERC721.init(web3: web, provider:web.provider, address: nftContract)
        return try await erc721.tokenOfOwnerByIndex(owner: owner, index: index)
    }
    
    class func getToken(_ owner : EthereumAddress,nftContract : EthereumAddress,web:Web3,tokenId:BigUInt) async throws -> String{
        let erc721 = ERC721.init(web3: web, provider:web.provider, address: nftContract)
        return try await erc721.tokenURI(tokenId: tokenId)
    }
    
    class func getNFTList(account: Account) async throws -> [NFT]{
        guard let userAddress = EthereumAddress(account.address) else {
            throw WalletError.inputError(desc: "address error")
        }
        
        guard let nftContract = await AppConfigController.shared.getNFTContrart()?.getContract(account.chainId) , nftContract.count > 0 else{
            return []
        }
        
        guard let contract = EthereumAddress(nftContract) else {
            throw WalletError.inputError(desc: "contract error")
        }
        
        guard let web = try? await WalletERC20.createWeb3(account: account) else{
            throw WalletError.rpcError(desc: nil)
        }
        ///获取nft数量
        let balance = try await getBalance(userAddress, nftContract: contract, web: web)

        var nfts : [NFT] = []
        for i in 0..<balance{
            ///查询nft ID
            let tokenId = try await getTokenId(userAddress, nftContract: contract, web: web, index: i)
            ///查询nft
            let token = try await getToken(userAddress, nftContract: contract, web: web, tokenId: tokenId)
            nfts.append(NFT(tokenId:Int(tokenId),logo: token,address: nftContract, chainId: account.chainId))
        }
        return nfts
    }
    
    //预估主网币购买gas
//    class func getBuyMainGasLimtRequest(account: Account,
//                                    gasPrice: BigUInt,amount:String) async throws -> BigUInt {
//        guard let nftContract = await AppConfigController.shared.getNFTContrart()?.getContract(account.chainId) , nftContract.count > 0 else{
//            return BigUInt(0)
//        }
//        let finalTransaction = try self.createMainBuyTransaction(account: account, gasPrice: gasPrice, amount: amount,nftContract: nftContract)
//        guard let we3P = try? await Web3HttpProvider(url:URL(string: account.chain.currentRPC)!, network: Networks.Custom(networkID: BigUInt(account.chain.chainId))) else {
//            throw WalletError.inputError(desc: "rpc error")
//        }
//        let web = Web3(provider: we3P)
//        let request: APIRequest = .estimateGas(finalTransaction, finalTransaction.callOnBlock ?? .latest)
//        return try await APIRequest.sendRequest(with: web.provider, for: request).result
//    }
    
//    class func buyMainRequest(account: Account,amount:String) async throws -> TransactionSendingResult? {
//        account.chain = Chain.BSCTest()
//        guard let gasPrice = await gasRequest(account: account).request() else{
//            throw WalletError.inputError(desc: "rpc error")
//        }
//        guard let nftContract = await AppConfigController.shared.getNFTContrart()?.getContract(account.chainId) , nftContract.count > 0 else{
//            return nil
//        }
//        var finalTransaction = try self.createMainBuyTransaction(account: account, gasPrice: gasPrice, amount: amount,nftContract: nftContract)
//
//        let gasLimit = try await self.getBuyMainGasLimtRequest(account: account, gasPrice: gasPrice, amount: amount)
//        finalTransaction.gasLimit = gasLimit
//
//        guard let we3P = try? await Web3HttpProvider(url:URL(string: account.chain.currentRPC)!, network: Networks.Custom(networkID: BigUInt(account.chain.chainId))) else {
//            throw WalletError.inputError(desc: "rpc error")
//        }
//        let web = Web3(provider: we3P)
//        guard let nonce = try? await web.eth.getTransactionCount(for: finalTransaction.from!) else{
//            throw WalletError.rpcError(desc: nil)
//        }
//        finalTransaction.nonce = nonce
//
//        let privateKey = Data(hex: account.privateKey.add0x)
//        try finalTransaction.sign(privateKey: privateKey)
//        return try await web.eth.send(raw: finalTransaction.encode()!)
//    }
    
    //预估USDT购买gas
//    class func getBuyUSDTGasLimtRequest(account: Account,
//                                    gasPrice: BigUInt,amount:String) async throws -> BigUInt {
//        guard let nftContract = await AppConfigController.shared.getNFTContrart()?.getContract(account.chainId) , nftContract.count > 0 else{
//            return BigUInt(0)
//        }
//        let finalTransaction = try self.createMainBuyTransaction(account: account, gasPrice: gasPrice, amount: amount,nftContract: nftContract)
//        guard let we3P = try? await Web3HttpProvider(url:URL(string: account.chain.currentRPC)!, network: Networks.Custom(networkID: BigUInt(account.chain.chainId))) else {
//            throw WalletError.inputError(desc: "rpc error")
//        }
//        let web = Web3(provider: we3P)
//        let request: APIRequest = .estimateGas(finalTransaction, finalTransaction.callOnBlock ?? .latest)
//        return try await APIRequest.sendRequest(with: web.provider, for: request).result
//    }
    
//    class func buyUSDTRequest(account: Account,amount:String) async throws -> TransactionSendingResult? {
//        account.chain = Chain.BSCTest()
//        guard let gasPrice = await gasRequest(account: account).request() else{
//            throw WalletError.inputError(desc: "rpc error")
//        }
//        guard let nftContract = await AppConfigController.shared.getNFTContrart()?.getContract(account.chainId) , nftContract.count > 0 else{
//            return nil
//        }
//        var finalTransaction = try self.createMainBuyTransaction(account: account, gasPrice: gasPrice, amount: amount , nftContract: nftContract)
//        
//        let gasLimit = try await self.getBuyUSDTGasLimtRequest(account: account, gasPrice: gasPrice, amount: amount)
//        finalTransaction.gasLimit = gasLimit
//        
//        guard let we3P = try? await Web3HttpProvider(url:URL(string: account.chain.currentRPC)!, network: Networks.Custom(networkID: BigUInt(account.chain.chainId))) else {
//            throw WalletError.inputError(desc: "rpc error")
//        }
//        let web = Web3(provider: we3P)
//        guard let nonce = try? await web.eth.getTransactionCount(for: finalTransaction.from!) else{
//            throw WalletError.rpcError(desc: nil)
//        }
//        finalTransaction.nonce = nonce
//        
//        let privateKey = Data(hex: account.privateKey.add0x)
//        try finalTransaction.sign(privateKey: privateKey)
//        return try await web.eth.send(raw: finalTransaction.encode()!)
//    }
}

extension ContractAPI{
//    class func createMainBuyTransaction(account: Account,gasPrice: BigUInt,
//                                        amount:String,nftContract : String) throws -> CodableTransaction{
//        guard let buyContractArress = EthereumAddress(nftContract) else {
//            throw WalletError.inputError(desc: "contract error")
//        }
//        guard let value = Utilities.parseToBigUInt(amount, decimals: 18) else {
//            throw WalletError.inputError(desc: "amount error")
//        }
//        var parameters : [AnyObject] =  [AnyObject]()
//        let jsonstr = NFTABI.getNFTContract()
//        let funstr = "mint"
//        parameters = [BigUInt(0)] as [AnyObject]
//
//        let contract = try EthereumContract.init(jsonstr, at: buyContractArress)
//        guard let transaction = contract.method(funstr, parameters: parameters, extraData: nil) else{
//            throw WalletError.inputError(desc: "abi error")
//        }
//        guard var finalTransaction = WalletERC20.createTransaction(transnum: amount, decimal: 18, gasPrice: gasPrice, fromAddress: account.address, toAddress: nftContract, chainId: account.chain.chainId) else{
//            throw WalletError.inputError(desc: "tx error")
//        }
//
//        finalTransaction.value = value
//        finalTransaction.data = transaction
//        return finalTransaction
//    }
    
//    class func createUSDTBuyTransaction(account: Account,gasPrice: BigUInt,
//                                        amount:String,nftContract:String) throws -> CodableTransaction{
//        guard let buyContractArress = EthereumAddress(nftContract) else {
//            throw WalletError.inputError(desc: "contract error")
//        }
//        guard let value = Utilities.parseToBigUInt(amount, decimals: 18) else {
//            throw WalletError.inputError(desc: "amount error")
//        }
//        var parameters : [AnyObject] =  [AnyObject]()
//        let jsonstr = NFTABI.getNFTContract()
//        let funstr = "mint"
//        parameters = [BigUInt(0)] as [AnyObject]
//        let contract = try EthereumContract.init(jsonstr, at: buyContractArress)
//        guard let transaction = contract.method(funstr, parameters: parameters, extraData: nil) else{
//            throw WalletError.inputError(desc: "abi error")
//        }
//        guard var finalTransaction = WalletERC20.createTransaction(transnum: amount, decimal: 18, gasPrice: gasPrice, fromAddress: account.address, toAddress: nftContract, chainId: account.chain.chainId) else{
//            throw WalletError.inputError(desc: "tx error")
//        }
//
//        finalTransaction.value = value
//        finalTransaction.data = transaction
//        return finalTransaction
//    }
}
