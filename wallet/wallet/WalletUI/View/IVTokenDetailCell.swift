//
//  IVTokenDetailCell.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/24.
//

import UIKit

class IVTokenDetailCell: IVBaseTableViewCell {
//    let iconType = UIImageView()
    let labAddress = UILabel.init(font:UIFont.TTTrialRegular(size: 13),textColor: UIColor(white: 1, alpha: 0.6))
    let labNum = UILabel.init(font:UIFont.TTTrialRegular(size: 13),textColor: UIColor(white: 1, alpha: 0.6))
    let labTime = UILabel.init(font:UIFont.TTTrialRegular(size: 10),textColor: UIColor(white: 1, alpha: 0.6))
    
    override func layoutUI() {
//        self.contentView.addSubview(iconType)
//        iconType.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(16.w)
//            make.centerY.equalToSuperview()
//        }
        
        self.contentView.addSubview(labAddress)
        labAddress.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalToSuperview().offset(15.w)
        }
        
        self.contentView.addSubview(labTime)
        labTime.snp.makeConstraints { make in
            make.left.equalTo(labAddress)
            make.top.equalTo(labAddress.snp.bottom).offset(5.w)
            make.bottom.equalToSuperview().offset(-15.w)
        }
        
        self.contentView.addSubview(labNum)
        labNum.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.w)
            make.centerY.equalToSuperview()
        }
        
        
        let line = UIView(color_CACACA06)
        self.contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
    }
    
    var model = IVTradeListModel(){
        didSet{
//            iconType.image = model.statusIcon
            self.labAddress.text = self.model.hash.showAddress()
            labTime.text = model.timeStamp.toyyyyMMdd("yyyy-MM-dd HH:mm")
            labNum.text = model.showValue
        }
    }

}
