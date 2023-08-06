//
//  IVSearchHeadReusableView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/5.
//

import UIKit

class IVSearchHeadReusableView: UICollectionReusableView {
    let labTitle = UILabel.init(font: UIFont.Medium(size: 15), textColor: UIColor.white,text: LocalHistoryRecord.localized)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(labTitle);
        labTitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16.w)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
