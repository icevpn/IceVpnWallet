//
//  IVWalletMainHeadItem.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/22.
//

import UIKit

class IVWalletMainHeadItem: UICollectionViewCell {
    
    var isOpenTransfer = false
    
    var changChainBlock : (()->())?
    
    var switchWallectBlock : (()->())?
    
    var manageBlock : (()->())?
    
    private let iconChain = UIImageView()
    
    private let labName = UILabel.init(font: UIFont.TTTrialBold(size: 14), textColor: UIColor.white)
    private let labChainName = UILabel.init(font: UIFont.TTTrialRegular(size: 14), textColor: UIColor.init(white: 1, alpha: 0.6))
    private let labMoney = UILabel.init(font: UIFont.TTTrialBold(size: 30), textColor: UIColor.white)
    private let labAddress = UILabel.init(font: UIFont.TTTrialMedium(size: 14), textColor: UIColor.init(white: 1, alpha: 0.6))
    private let itemView = UIView()
//    private let transferBG = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    func layoutUI() {
        let contentView = UIView()
        contentView.addLeftTopToRightBottomGradient(colors: [color_AD01BA.cgColor,color_3A00F9.cgColor], size: CGSize(width: 343.w, height: 202.w), cornerRadius: 8.w)
        self.contentView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16.w)
            make.size.equalTo(CGSize(width: 343.w, height: 202.w))
        };
//        contentView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(closeTransfer)))
        
        iconChain.isUserInteractionEnabled = true
        iconChain.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickChain)))
        iconChain.dealLayer(corner: 14.w)
        contentView.addSubview(iconChain)
        iconChain.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(16.w)
            make.size.equalTo(CGSize(width: 28.w, height: 28.w))
        }
        
        labName.isUserInteractionEnabled = true
        labName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickChain)))
        contentView.addSubview(labName)
        labName.snp.makeConstraints { (make) in
            make.left.equalTo(iconChain.snp.right).offset(4.w)
            make.centerY.equalTo(iconChain)
        }
        
        labChainName.isUserInteractionEnabled = true
        labChainName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickChain)))
        contentView.addSubview(labChainName)
        labChainName.snp.makeConstraints { (make) in
            make.left.equalTo(labName.snp.right).offset(4.w)
            make.centerY.equalTo(iconChain)
        }
        
        let iconArrow = UIImageView(image: UIImage(named: "icon_wallet_arrow")?.withRenderingMode(.alwaysTemplate))
        iconArrow.isUserInteractionEnabled = true
        iconArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickChain)))
        iconArrow.tintColor = UIColor.init(white: 1, alpha: 0.6)
        contentView.addSubview(iconArrow)
        iconArrow.snp.makeConstraints { (make) in
            make.left.equalTo(labChainName.snp.right).offset(3.w)
            make.centerY.equalTo(iconChain)
        }
        
        
        let labManage = UILabel.init(font: UIFont.TTTrialRegular(size: 14), textColor: UIColor.init(white: 1, alpha: 0.6),text: LocalManage.localized)
        labManage.isUserInteractionEnabled = true
        labManage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickManage)))
        contentView.addSubview(labManage)
        labManage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16.w)
            make.centerY.equalTo(iconChain)
        }
//        let btnSwitch = UIButton.init(image: UIImage(named: "icon_wallet_switch"))
//        btnSwitch.addTarget(self, action: #selector(onclickSwitch), for: .touchUpInside)
//        contentView.addSubview(btnSwitch)
//        btnSwitch.snp.makeConstraints { (make) in
//            make.right.equalToSuperview()
//            make.centerY.equalTo(labName)
//            make.size.equalTo(CGSize(width: 54.w, height: 40.w))
//        }
        
        contentView.addSubview(labMoney)
        labMoney.snp.makeConstraints { (make) in
            make.left.equalTo(iconChain)
            make.top.equalTo(labName.snp.bottom).offset(10.w)
        }
        
        contentView.addSubview(labAddress)
        labAddress.snp.makeConstraints { (make) in
            make.left.equalTo(iconChain)
            make.top.equalTo(labMoney.snp.bottom).offset(8.w)
        }
        let btnSwitch = UIButton(type: .system)
        btnSwitch.setImage(UIImage(named: "icon_copy"), for: .normal)
        btnSwitch.addTarget(self, action: #selector(onclickCopy), for: .touchUpInside)
        btnSwitch.tintColor = UIColor(white: 1, alpha: 0.6)
        contentView.addSubview(btnSwitch)
        btnSwitch.snp.makeConstraints { (make) in
            make.left.equalTo(labAddress.snp.right)
            make.centerY.equalTo(labAddress)
            make.size.equalTo(CGSize(width: 20.w, height: 40.w))
        }
        
        contentView.addSubview(itemView)
        itemView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    func addItem(_ chainId : Int) {
        itemView.removeAllSubviews()
        let items = [
            IVWalletHeadItemModel.init(icon:UIImage(named: "icon_wallet_sendTo"),title: LocalSendTo.localized, tag: 1),
            IVWalletHeadItemModel.init(icon:UIImage(named: "icon_wallet_expenditure"),title: LocalReceive.localized, tag: 2),
            ]
        let count : CGFloat = CGFloat(items.count)
        let width : CGFloat = 343.w/count
        var leftView : UIView = itemView
        for (index,item) in items.enumerated() {
            let view = self.createItem(item)
            itemView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.left.equalTo(index == 0 ? leftView : leftView.snp.right)
                make.bottom.equalToSuperview().offset(-10.w)
                make.top.equalToSuperview()
                make.width.equalTo(width)
                make.height.equalTo(65.w)
            }
            leftView = view
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
        let lab = UILabel.init(font: UIFont.TTTrialMedium(size: 12),textColor: UIColor.white,text: data.title)
        lab.tag = 100
        view.addSubview(lab)
        lab.snp.makeConstraints { make in
            make.centerX.equalTo(icon)
            make.top.equalTo(icon.snp.bottom).offset(8.w)
        }
        return view
    }
    
    var model : Account?{
        didSet{
            self.labMoney.text = "\(model?.mainToken?.balance ?? "0.00")"
            self.labName.text = self.model?.name
            self.labChainName.text = self.model?.chain.chainSymbol ?? "ETH"
            self.labAddress.text = self.model?.address.showAddress(11)
            self.iconChain.sd_setImage(with: URL(string: self.model?.chain.icon ?? ""),placeholderImage: UIImage(named: "icon_placeholder"))
            addItem(self.model?.chain.chainId ?? 1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IVWalletMainHeadItem : PasteboardProtocol{
    @objc func onclickChain(){
        self.changChainBlock?()
    }
    
    @objc func onclickManage(){
        self.manageBlock?()
    }
    
    @objc func onclickCopy(){
        pastWord(str: self.model?.address ?? "")
    }
    
    @objc func onclickSwitch(){
        self.changChainBlock?()
    }
    
    @objc func onclickItem(_ tap : UITapGestureRecognizer){
        if tap.view?.tag == 11 {
            sendTo()
            return
        }
        if tap.view?.tag == 12 {
            recive()
            
            return
        }
        if tap.view?.tag == 13 {
            nft()
            return
        }
        if tap.view?.tag == 14 {
            dapp()
            return
        }
    }
    
    
    func sendTo(){
        IVRouter.to(name: .sendTo)
    }
    
    func nft(){
    }
    
    func recive() {
        IVRouter.to(name: .recive)
    }
    
    func dapp(){
        IVRouter.to(name: .dappList)
    }
}
