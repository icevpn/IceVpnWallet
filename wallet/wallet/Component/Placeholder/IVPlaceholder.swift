//
//  EmptyView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/29.
//

import UIKit

enum IVPlaceholder {
    case empty
    
    static func show(_ type: IVPlaceholder = empty,frame: CGRect = CGRectMake(0, 0, Screen_width, Screen_height - 100.h),centerY : CGFloat = 0) -> UIView {
        return IVEmptyView.createView(type,frame: frame,centerY: centerY)
    }
}

class IVEmptyView {
    class func createView(_ type : IVPlaceholder,frame: CGRect,centerY : CGFloat) -> UIView{
        return createEmptyView(frame,centerY: centerY)
    }
    
    class func createEmptyView(_ frame : CGRect,centerY : CGFloat) -> UIView{
        let view = UIView.init(frame: frame)
        let icon = UIImageView.init(image: UIImage(named: "icon_empty"))
        view.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(centerY)
            make.size.equalTo(CGSize.init(width: 268.w, height: 163.w))
        }
        return view
    }
    
}
