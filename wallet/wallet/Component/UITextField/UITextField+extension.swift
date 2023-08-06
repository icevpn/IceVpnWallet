//
//  UITextField+extension.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/6.
//

import UIKit

extension UITextField{
    convenience init(_ placeholder : String? = nil , font : UIFont? = nil , textColor : UIColor? = nil,showSearchIcon:Bool = false,textHeight:CGFloat = 45.w) {
        self.init()
        if let placeholder = placeholder {
            self.attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(white: 1, alpha: 0.6)])
        }
        if let font = font {
            self.font = font
        }
        if let textColor = textColor {
            self.textColor = textColor
        }
        if (showSearchIcon){
            self.addLeftSearch(textHeight)
        }
    }
    
    func addLeftSearch(_ height : CGFloat){
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 38.w, height: height))
        let imageV = UIImageView.init(image:UIImage(named: "icon_dapp_search"))
        imageV.frame = CGRect.init(x: 16.w, y: (height - 13.w)/2, width: 13.w, height: 13.w)
        view.addSubview(imageV)
        self.leftViewMode = .always
        self.leftView = view
    }
    
    func leftWidth(_ width : CGFloat) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 1))
        self.leftViewMode = .always
        self.leftView = view
    }
    
    func addPlaceholder(_ placeholder :String)  {
        self.attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color_4D4A68])
    }
}
