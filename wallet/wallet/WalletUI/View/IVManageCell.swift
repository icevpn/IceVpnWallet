//
//  IVManageCell.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/16.
//

import UIKit

class IVManageCell: IVBaseTableViewCell {
    let labTitle = UILabel(font: UIFont.Regular(size: 15),textColor: UIColor.white)
    let labContent = UILabel(font: UIFont.Regular(size: 13),textColor: UIColor(white: 1, alpha: 0.6))
    let arrowIcon = UIImageView(image: UIImage(named: "icon_right_arrow")?.withRenderingMode(.alwaysTemplate))
    override func layoutUI() {
        self.backgroundColor = UIColor.clear
        let bgView = UIView(UIColor.init(white: 1, alpha: 0.08))
        bgView.dealLayer(corner: 8.w)
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 8.w, left: 16.w, bottom: 8.w, right: 16.w))
        }
        
        bgView.addSubview(labTitle)
        labTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16.w)
        }
        
        bgView.addSubview(labContent)
        labContent.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16.w)
        }
        
        arrowIcon.tintColor = UIColor(white: 1, alpha: 0.6)
        bgView.addSubview(arrowIcon)
        arrowIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16.w)
        }
        
    }
    
    var model : IVManageModel!{
        didSet{
            labTitle.text = model.title
            labContent.text = model.content
            if model.type == .arrow{
                arrowIcon.isHidden = false
                labContent.snp.updateConstraints { make in
                    make.right.equalToSuperview().offset(-50.w)
                }
            }else{
                arrowIcon.isHidden = true
                labContent.snp.updateConstraints { make in
                    make.right.equalToSuperview().offset(-16.w)
                }
            }
            
        }
    }
    
}
