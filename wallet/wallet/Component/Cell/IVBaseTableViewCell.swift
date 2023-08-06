//
//  IVBaseTableViewCell.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/1.
//

import UIKit

class IVBaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.layoutUI()
    }
    
    func layoutUI() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
