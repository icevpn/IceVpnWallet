//
//  IVWalletTokenItem.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/23.
//

import UIKit

class IVWalletTokenItem: UICollectionViewCell {
    let icon = UIImageView()
    let labName = UILabel.init(font:UIFont.TTTrialMedium(size: 15),textColor: UIColor.white)
    let labAmount = UILabel.init(font:UIFont.TTTrialBold(size: 15),textColor: UIColor.white)
    let bgView = UIView(UIColor.init(white: 1, alpha: 0.08))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutUI() {
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
        
        bgView.addSubview(labAmount)
        labAmount.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16.w)
        }
    }
    
    var model : Token!{
        didSet{
        
            icon.sd_setImage(with: URL(string: model.logo),placeholderImage: UIImage(named: "icon_placeholder"))
            labName.text = model.symbol
            labAmount.text = model.balance
        }
    }
}
