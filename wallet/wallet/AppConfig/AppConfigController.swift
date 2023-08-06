//
//  AppConfigController.swift
//  ICE VPN
//
//  Created by tgg on 2023/7/6.
//

import UIKit


class AppConfigController: NSObject {
    let contractPath = "contract.json"
    
    static let shared = AppConfigController()
    
    var nftContrart : IVNFTContract?
    @discardableResult
    func getNFTContrart() async -> IVNFTContract?{
        if (nftContrart != nil){
            return nftContrart
        }
        let data = await getConfig(contractPath)
        if let model = IVNFTContract.deserialize(from: data){
            self.nftContrart = model
            return model
        }
        return nil
    }
    
    
    func getConfig(_ configPath : String) async -> [String:Any]?{
        return try? await withCheckedThrowingContinuation({ continuation in
            let request:URLRequest = URLRequest(url: URL(string:  "\(app_config_path)\(configPath)")!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
            let dataTask = URLSession.shared.dataTask(with: request,
                                                      completionHandler: {(data, response, error) -> Void in
                if error != nil{
                    continuation.resume(returning: nil)
                }else{
                    let str = String(data: data!, encoding: String.Encoding.utf8)
                    let dict = str?.toDictionary()
                    continuation.resume(returning: dict)
                }
            }) as URLSessionTask
             
            dataTask.resume()
        })
    }
}
