//
//  IVJSONProtocol.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/9.
//

import Foundation

protocol IVJSONProtocol {
    func jsonToData(json:Any) -> Data?
}

extension IVJSONProtocol{
    func jsonToData(json:Any) -> Data?{
        if (!JSONSerialization.isValidJSONObject(json)){
            return nil
        }
        let data = try? JSONSerialization.data(withJSONObject: json)
        return data
    }
}
