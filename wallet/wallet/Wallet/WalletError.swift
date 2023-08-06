//
//  WalletError.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/23.
//

import UIKit

public enum WalletError: Error {
    case gasError(desc:String?)
    case addressError(desc:String?)
    case rpcError(desc:String?)
    case inputError(desc:String)
    case unknownError
    
    public var errorDescription: String {
        switch self {
        case .gasError(let desc):
            return desc ?? "gas error"
        case .addressError(let desc):
            return desc ?? "address error"
        case .rpcError(let desc):
            return desc ?? "rpc error"
        case .inputError(let desc):
            return desc
        case .unknownError:
            return "Unknown Error"
        }
    }
}
