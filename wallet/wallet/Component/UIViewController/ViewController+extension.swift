//
//  ViewController+extension.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/5.
//

import UIKit
extension UIViewController{
    
    
    func addRightItem(_ image : UIImage?){
        var items = [UIBarButtonItem]()
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn.setImage(image, for: .normal)
        btn.contentHorizontalAlignment = .right
        btn.addTarget(self, action: #selector(onRightAction), for: .touchUpInside)
        let btnItem = UIBarButtonItem(customView: btn)
        items.append(btnItem)
        self.navigationItem.rightBarButtonItems = items
    }
    
    func addRightItem(_ title : String){
        let width = title.width(CGSize(width: 100, height: 20), font: UIFont.Regular(size: 12))
        var items = [UIBarButtonItem]()
        let btn = UIButton(title: title,font: UIFont.Regular(size: 12),color: UIColor(white: 1, alpha: 0.6))
        btn.frame = CGRect(x: 0, y: 0, width: width + 10, height: 30)
        btn.addTarget(self, action: #selector(onRightAction), for: .touchUpInside)
        let btnItem = UIBarButtonItem(customView: btn)
        items.append(btnItem)
        self.navigationItem.rightBarButtonItems = items
    }
    
    var navHeight : CGFloat{
        get{
            return (navigationController?.navigationBar.frame.size.height ?? 44) + statusBarH
        }
    }
}

extension UIViewController{
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onRightAction(){
        
    }
}
