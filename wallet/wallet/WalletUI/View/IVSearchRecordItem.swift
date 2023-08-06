//
//  IVSearchRecordItem.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/5.
//

import UIKit

class IVSearchRecordItem: UICollectionViewCell {
    let labTitle = UILabel.init(font: UIFont.Regular(size: 15), textColor: UIColor.white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        labTitle.textAlignment = .center
        labTitle.backgroundColor = UIColor.init(white: 1, alpha: 0.08)
        labTitle.dealLayer(corner: 13.w)
        self.contentView.addSubview(labTitle)
        labTitle.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var value = ""{
        didSet{
            labTitle.text = value
        }
    }
}
