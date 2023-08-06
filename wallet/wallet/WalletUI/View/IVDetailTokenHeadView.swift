//
//  IVDetailTokenHeadView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/24.
//

import UIKit

class IVDetailTokenHeadView: UIView {
    private let icon = UIImageView()
    private let labMoney = UILabel.init(font: UIFont.TTTrialBold(size: 30), textColor: UIColor.white)
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    func layoutUI() {
        let contentView = UIView()
        contentView.addLeftTopToRightBottomGradient(colors: [color_AD01BA.cgColor,color_3A00F9.cgColor], size: CGSize(width: 343.w, height: 202.w), cornerRadius: 8.w)
        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16.w)
            make.size.equalTo(CGSize(width: 343.w, height: 202.w))
        };
//        contentView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(closeTransfer)))
        
        icon.dealLayer(corner: 22.w)
        contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16.w)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 44.w, height: 44.w))
        }
        
        contentView.addSubview(labMoney)
        labMoney.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(10.w)
        }
        
        let sendView = self.createItem(IVWalletHeadItemModel.init(icon:UIImage(named: "icon_wallet_sendTo"),title: LocalSendTo.localized, tag: 1))
        contentView.addSubview(sendView)
        sendView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(labMoney.snp.bottom).offset(10.w)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        let receiveView = self.createItem(IVWalletHeadItemModel.init(icon:UIImage(named: "icon_wallet_qrcode"),title: LocalReceive.localized, tag: 2))
        contentView.addSubview(receiveView)
        receiveView.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.top.equalTo(labMoney.snp.bottom).offset(10.w)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    func createItem(_ data :IVWalletHeadItemModel) -> UIView{
        let view = UIView()
        view.tag = data.tag + 10
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onclickItem(_:))))
        let icon = UIImageView(image: data.icon)
        icon.tag = 99
        view.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 40.w, height: 40.w))
        }
        let lab = UILabel.init(font: UIFont.TTTrialRegular(size: 12),textColor: UIColor.white,text: data.title)
        lab.tag = 100
        view.addSubview(lab)
        lab.snp.makeConstraints { make in
            make.centerX.equalTo(icon)
            make.top.equalTo(icon.snp.bottom).offset(8.w)
        }
        return view
    }
    
    
    
    var model : Token?{
        didSet{
            self.labMoney.text = "\(model?.balance ?? "0.00") \(model?.symbol ?? "")"
            self.icon.sd_setImage(with: URL(string: self.model?.logo ?? ""),placeholderImage: UIImage(named: "icon_placeholder"))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IVDetailTokenHeadView{
    @objc func onclickItem(_ tap : UITapGestureRecognizer){
        if tap.view?.tag == 11 {
            sendTo()
            return
        }
        if tap.view?.tag == 12 {
            qrcode()
            return
        }
    }
    
    func sendTo(){
        IVRouter.to(name: .sendTo)
    }
    
    func qrcode() {
        IVRouter.to(name: .recive)
    }
}
