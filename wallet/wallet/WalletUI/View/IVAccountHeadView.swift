//
//  IVAccountHeadView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/14.
//

import UIKit

class IVAccountHeadView: UIView {
    private var cards : [IVAccountCardModel]!
    convenience init(frame : CGRect,cards : [IVAccountCardModel]) {
        self.init(frame: frame)
        self.cards = cards
        self.createUI()
    }
    
    func createUI() {
        let bgView = UIView(UIColor(white: 1, alpha: 0.08))
        bgView.dealLayer(corner: 8.w)
        self.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(343.w)
            make.top.bottom.equalToSuperview()
        }
        
        for (index,model) in self.cards.enumerated(){
            let itemView = self.item(model)
            bgView.addSubview(itemView)
            itemView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(12.w)
                make.right.equalToSuperview().offset(-12.w)
                make.top.equalToSuperview().offset(CGFloat(index)*50.w)
                make.height.equalTo(50.w)
            }
            
            if (index < self.cards.count - 1){
                let line = UIView(color_DDDDDD)
                bgView.addSubview(line)
                line.snp.makeConstraints { make in
                    make.left.right.bottom.equalTo(itemView)
                    make.height.equalTo(0.5)
                }
            }
        }
    }
    
    func item(_ card : IVAccountCardModel) -> UIView {
        let view = UIView()
        let labIcon = UILabel(font: UIFont.TTTrialBlack(size: 14),textColor: UIColor.white,text: card.first)
        labIcon.textAlignment = .center
        labIcon.backgroundColor = color_7146FF
        labIcon.dealLayer(corner: 4.w)
        view.addSubview(labIcon)
        labIcon.snp.makeConstraints { make in
            make.centerY.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 24.w, height: 24.w))
        }
        
        let labName = UILabel(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.white,text: card.name)
        view.addSubview(labName)
        labName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(labIcon.snp.right).offset(8.w)
        }
        
        let labNum = UILabel(font: UIFont.TTTrialBold(size: 14),textColor: UIColor.white,text: "\(card.num)")
        view.addSubview(labNum)
        labNum.snp.makeConstraints { make in
            make.centerY.right.equalToSuperview()
        }
        return view
    }
    
}
