//
//  IVNFTItem.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/23.
//

import UIKit

class IVNFTItem: UICollectionViewCell {
    let icon = UIImageView()
    let labName = UILabel.init(font: UIFont.TTTrialMedium(size: 15), textColor: UIColor.white)
    let labTokenId = UILabel.init(font: UIFont.TTTrialMedium(size: 15), textColor: UIColor.white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        icon.dealLayer(corner: 8.w)
        self.addSubview(icon);
        icon.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 160.w, height: 160.w))
        }
        
        let textView = UIView()
        textView.addTopToDownGradient(colors: [UIColor.clear.cgColor,UIColor(white: 1, alpha: 0.6).cgColor], size: CGSize(width: 160.w, height: 32.w), cornerRadius: 8.w)
        icon.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(icon)
            make.height.equalTo(32.w)
        }
        
        textView.addSubview(labName);
        labName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12.w)
            make.centerY.equalToSuperview()
        }
        
        textView.addSubview(labTokenId);
        labTokenId.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12.w)
            make.centerY.equalToSuperview()
        }
    }
    
    var model : NFT?{
        didSet{
            icon.sd_setImage(with: URL(string: model?.logo ?? ""),placeholderImage: UIImage(named: "icon_placeholder"))
            labTokenId.text = "#\(model?.tokenId ?? 0)"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
