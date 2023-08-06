//
//  IVWalletHeadReusableView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/23.
//

import UIKit

class IVWalletHeadReusableView: UICollectionReusableView {
    
    var typeBlock : ((Int)->())?
    
    let labToken = UILabel.init(font: UIFont.TTTrialMedium(size: 16), textColor: UIColor.white,text: "Token")
    
    let labNFT = UILabel.init(font: UIFont.TTTrialMedium(size: 16), textColor: UIColor(white: 1, alpha: 0.6),text: "NFT")
    
    let line = UIView(UIColor.white)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        labToken.tag = 0
        labToken.textAlignment = .center
        labToken.isUserInteractionEnabled = true
        labToken.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickType(_:))))
        self.addSubview(labToken);
        labToken.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5.w)
            make.width.equalToSuperview().multipliedBy(1/2.0)
        }
        
        labNFT.tag = 1
        labNFT.textAlignment = .center
        labNFT.isUserInteractionEnabled = true
        labNFT.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickType(_:))))
        self.addSubview(labNFT);
        labNFT.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5.w)
            make.width.equalToSuperview().multipliedBy(1/2.0)
        }
        
        self.addSubview(line);
        line.snp.makeConstraints { (make) in
            make.centerX.equalTo(labToken)
            make.bottom.equalToSuperview().offset(-7.w)
            make.size.equalTo(CGSize(width: 44.w, height: 2.w))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func onclickType(_ tap : UITapGestureRecognizer){
        guard let tag = tap.view?.tag else{
            return
        }
        typeBlock?(tag)
        if tag == 0{
            UIView.animate(withDuration: 0.2) {
                self.line.snp.updateConstraints { make in
                    make.centerX.equalTo(self.labToken)
                }
                self.line.superview?.layoutIfNeeded()
            }
        }else{
            UIView.animate(withDuration: 0.2) {
                self.line.snp.updateConstraints { make in
                    make.centerX.equalTo(self.labToken).offset(Screen_width/2.0)
                }
                self.line.superview?.layoutIfNeeded()
            }
        }
        labToken.textColor = tag == 0 ? UIColor.white : UIColor(white: 1, alpha: 0.6)
        labNFT.textColor = tag == 1 ? UIColor.white : UIColor(white: 1, alpha: 0.6)
    }
}
