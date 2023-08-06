//
//  IVTransferHeadView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/9.
//

import UIKit

class IVTransferHeadView: UIView {
    var isToWallet = true
    let labForm = UILabel(font: UIFont.TTTrialBold(size: 16),textColor: UIColor.white,text: "ICE")
    let labTo = UILabel(font: UIFont.TTTrialBold(size: 16),textColor: UIColor.white,text: "Wallet")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bgView = UIView()
        bgView.addLeftTopToRightBottomGradient(colors: [color_AD01BA.cgColor,color_3A00F9.cgColor], size: CGSize(width: 343.w, height: 140.w), cornerRadius: 8.w)
        self.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let formView = createItem(UIImage(named: "icon_wallet_from"), title: "from", lab: labForm)
        bgView.addSubview(formView)
        formView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        let toView = createItem(UIImage(named: "icon_wallet_to"), title: "to", lab: labTo)
        bgView.addSubview(toView)
        toView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        let line = UIView(color_979797)
        bgView.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-30.w)
            make.height.equalTo(0.5)
            make.centerY.equalToSuperview()
        }
        
        let btnSwitch = UIButton(image: UIImage(named: "icon_wallet_transfer_switch"))
        btnSwitch.addTarget(self, action: #selector(onclickSwitch), for: .touchUpInside)
        bgView.addSubview(btnSwitch)
        btnSwitch.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.w)
            make.size.equalTo(CGSize(width: 43.w, height: 43.w))
            make.centerY.equalToSuperview()
        }
        
    }
    
    func createItem(_ icon : UIImage?,title:String,lab:UILabel) -> UIView{
        let view = UIView()
        let icon = UIImageView(image: icon)
        view.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16.w)
            make.size.equalTo(CGSize(width: 28.w, height: 28.w))
        }
        let labTitle = UILabel.init(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.white,text: title)
        view.addSubview(labTitle)
        labTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(12.w)
        }
        view.addSubview(lab)
        lab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(150.w)
        }
        return view
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
}

extension IVTransferHeadView{
    @objc func onclickSwitch(){
        isToWallet = !isToWallet
        labForm.text = isToWallet ? "ICE" : "Wallet"
        labTo.text = !isToWallet ? "ICE" : "Wallet"
    }
}
