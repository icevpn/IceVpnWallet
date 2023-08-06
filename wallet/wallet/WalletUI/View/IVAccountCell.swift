//
//  IVAccountCell.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/14.
//

import UIKit

class IVAccountCell: IVBaseTableViewCell {
    let icon = UIImageView()
    let labName = UILabel.init(font:UIFont.TTTrialBold(size: 15),textColor: UIColor.white)
    let labDes = UILabel.init(font:UIFont.TTTrialRegular(size: 12),textColor: UIColor(white: 1, alpha: 0.6))
    let labAmount = UILabel.init(font:UIFont.TTTrialBold(size: 15),textColor: UIColor.white)
    let labTime = UILabel.init(font:UIFont.TTTrialRegular(size: 12),textColor: UIColor(white: 1, alpha: 0.6))
    override func layoutUI() {
        self.backgroundColor = UIColor.clear
        
        icon.dealLayer(corner: 16.w)
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14.w)
            make.bottom.equalToSuperview().offset(-14.w)
            make.left.equalToSuperview().offset(16.w)
            make.size.equalTo(CGSize.init(width: 32.w, height: 32.w))
        }
        
        self.contentView.addSubview(labName)
        labName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.w)
            make.left.equalTo(icon.snp.right).offset(12.w)
        }
        
        self.contentView.addSubview(labDes)
        labDes.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12.w)
            make.left.equalTo(labName)
        }
        
        self.contentView.addSubview(labAmount)
        labAmount.snp.makeConstraints { make in
            make.centerY.equalTo(labName)
            make.right.equalToSuperview().offset(-16.w)
        }
        
        self.contentView.addSubview(labTime)
        labTime.snp.makeConstraints { make in
            make.centerY.equalTo(labDes)
            make.right.equalTo(labAmount)
        }
    }
    
}
