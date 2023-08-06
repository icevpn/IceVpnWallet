//
//  UIButton+extension.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/1.
//

import UIKit
extension UIButton{
    convenience init(title : String? = nil,selectTitle : String? = nil,font : UIFont? = nil , color : UIColor? = nil , selectColor : UIColor? = nil , image : UIImage? = nil , selectImage : UIImage? = nil,backgroundColor : UIColor? = nil, backgroundImage: UIImage? = nil, selectBackgroundImage: UIImage? = nil) {
        self.init()
        self.setTitle(title, for: UIControl.State.normal)
        if let font = font {
            self.titleLabel?.font = font
        }
        if let color = color {
            self.setTitleColor(color, for: UIControl.State.normal)
        }
        if let selectColor = selectColor {
            self.setTitleColor(selectColor, for: UIControl.State.selected)
        }
        if let image = image {
            self.setImage(image, for: UIControl.State.normal)
        }
        if let selectImage = selectImage {
            self.setImage(selectImage, for: UIControl.State.selected)
        }
        if let selectTitle = selectTitle {
            self.setTitle(selectTitle, for: UIControl.State.selected)
        }
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let backgroundImage = backgroundImage {
            self.setBackgroundImage(backgroundImage, for: .normal) 
        }
        if let selectBackgroundImage = selectBackgroundImage {
            self.setBackgroundImage(selectBackgroundImage, for: .selected)
        }
    }
    
    ///提交按钮
    convenience init(submitTite:String,size: CGSize = CGSize(width: 343.w, height: 50.w),radius:CGFloat = 25.w) {
        self.init(title:submitTite,font: UIFont.TTTrialBold(size: 17),color: UIColor.white)
        self.addLeftTopToRightBottomGradient(colors: [color_AD01BA.cgColor,color_3A00F9.cgColor], size: size, cornerRadius: radius)
    }
}
