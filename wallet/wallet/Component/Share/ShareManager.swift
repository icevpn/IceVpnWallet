//
//  ShareManager.swift
//  ICE VPN
//
//  Created by HaydenYe on 2023/7/18.
//

import UIKit

class ShareManager {
    class func shareToPaltm(title: String,image: UIImage?,urlStr: String?) {
       var items = [Any]()
       if title.count != 0 {
           items.append(title)
       }
       if let image = image{
           items.append(image)
       }
       if let urlStr = urlStr, let url = URL(string: urlStr){
           items.append(url)
       }
       let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
       if let nav = UIUtil.visibleVC() {
           nav.present(vc, animated: true, completion: nil)
       }
   }
}

