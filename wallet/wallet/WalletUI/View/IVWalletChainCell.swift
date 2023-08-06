//
//  IVWalletChainCell.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/13.
//

import UIKit

class IVWalletChainCell: IVBaseTableViewCell {
    let icon = UIImageView()
    let labName = UILabel.init(font:UIFont.TTTrialRegular(size: 15),textColor: UIColor.white)
    let bgView = UIView(UIColor.init(white: 1, alpha: 0.08))
    override func layoutUI() {
        self.backgroundColor = UIColor.clear
        
        bgView.dealLayer(corner: 8.w)
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 6.w, left: 16.w, bottom: 6.w, right: 16.w))
        }
        
        icon.dealLayer(corner: 16.w)
        bgView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16.w)
            make.size.equalTo(CGSize.init(width: 32.w, height: 32.w))
        }
        
        bgView.addSubview(labName)
        labName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(12.w)
        }
        
    }
    
    var model : Chain!{
        didSet{
            icon.sd_setImage(with: URL(string: model.icon),placeholderImage: UIImage(named: "icon_placeholder"))
            labName.text = model.chainSymbol
        }
    }
}

