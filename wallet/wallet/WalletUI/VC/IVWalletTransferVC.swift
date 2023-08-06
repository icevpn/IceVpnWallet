//
//  IVWalletTransferVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/8.
//

import UIKit

class IVWalletTransferVC: IVBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Transfer"
        self.createUI()
    }
    
    func createUI() {
        let transferView = IVTransferHeadView()
        transferView.dealBorderLayer(corner: 8.w, bordercolor: color_979797, borderwidth: 1)
        self.view.addSubview(transferView)
        transferView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(28.h + navHeight)
            make.size.equalTo(CGSize(width: 343.w, height: 140.w))
        }
        
        let labAssetTitile = UILabel.init(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.init(white: 1, alpha: 0.6),text: "Asset")
        self.view.addSubview(labAssetTitile)
        labAssetTitile.snp.makeConstraints { make in
            make.top.equalTo(transferView.snp.bottom).offset(28.w)
            make.left.equalToSuperview().offset(16.w)
        }
        
        let assetView = UIView(UIColor.init(white: 1, alpha: 0.08))
        assetView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onclickShowToken)))
        assetView.dealLayer(corner: 8.w)
        self.view.addSubview(assetView)
        assetView.snp.makeConstraints { make in
            make.top.equalTo(labAssetTitile.snp.bottom).offset(16.w)
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.height.equalTo(48.w)
        }
        
        assetView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 32.w, height: 32.w))
        }
        
        assetView.addSubview(labSymbol)
        labSymbol.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(12.w)
        }
        
        assetView.addSubview(assetArrow)
        assetArrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16.w)
        }
        
        let labAmountTitile = UILabel.init(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.init(white: 1, alpha: 0.6),text: "Amount")
        self.view.addSubview(labAmountTitile)
        labAmountTitile.snp.makeConstraints { make in
            make.top.equalTo(assetView.snp.bottom).offset(28.w)
            make.left.equalToSuperview().offset(16.w)
        }
        
        let amountView = UIView(UIColor.init(white: 1, alpha: 0.08))
        amountView.dealLayer(corner: 8.w)
        self.view.addSubview(amountView)
        amountView.snp.makeConstraints { make in
            make.top.equalTo(labAmountTitile.snp.bottom).offset(16.w)
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.height.equalTo(48.w)
        }
        
        amountView.addSubview(textAmount)
        textAmount.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 0, left: 16.w, bottom: 0, right: 80.w))
        }
        
        let btnAll = UIButton.init(title: "All",font: UIFont.TTTrialBold(size: 14),color: UIColor.white)
        btnAll.addTarget(self, action: #selector(onclickAll), for: .touchUpInside)
        amountView.addSubview(btnAll)
        btnAll.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(48.w)
        }
        
        let btnConfirm = UIButton.init(title:LocalConfirm.localized,font: UIFont.TTTrialBold(size: 17),color: UIColor.white)
        btnConfirm.addTarget(self, action: #selector(onclickConfirm), for: UIControl.Event.touchUpInside)
        btnConfirm.addLeftTopToRightBottomGradient(colors: [color_AD01BA.cgColor,color_3A00F9.cgColor], size: CGSize(width: 343.w, height: 51.w), cornerRadius: 25.w)
        self.view.addSubview(btnConfirm)
        btnConfirm.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-safeBottomH-10.w)
            make.size.equalTo(CGSize.init(width: 343.w, height: 50.w))
        }
        
        self.view.addSubview(selectTokenView)
        selectTokenView.snp.makeConstraints { make in
            make.left.right.equalTo(assetView)
            make.top.equalTo(assetView.snp.bottom).offset(10.w)
            make.height.equalTo(0)
        }
    }
    
    lazy var selectToken : Token = {
        let token = Account.currentAccount?.mainToken ?? Token()
        return token
    }()
    
    lazy var assetArrow : UIImageView = {
        let icon = UIImageView(image: UIImage(named: "icon_wallet_arrow"))
        icon.tag = 0
        return icon
    }()
    
    lazy var icon : UIImageView = {
        let icon = UIImageView()
        icon.dealLayer(corner: 16.w)
        icon.sd_setImage(with: URL(string: selectToken.logo),placeholderImage: UIImage(named: "icon_placeholder"))
        return icon
    }()
    
    lazy var labSymbol : UILabel = {
        let lab = UILabel.init(font: UIFont.TTTrialRegular(size: 15),textColor: UIColor.white ,text: selectToken.symbol)
        return lab
    }()
    
    lazy var labAssetName : UILabel = {
        let lab = UILabel.init(font: UIFont.TTTrialRegular(size: 15),textColor: UIColor.white,text: selectToken.symbol)
        return lab
    }()
    
    lazy var textAmount : UITextField = {
        let text = UITextField("0.0",font: UIFont.TTTrialBold(size: 14),textColor: UIColor.white)
        text.keyboardType = .decimalPad
        return text
    }()
    
    lazy var selectTokenView : IVTransferSelectTokenView = {
        let view = IVTransferSelectTokenView(Account.currentAccount?.tokens ?? [])
        view.dealLayer(corner: 8.w)
        view.isHidden = true
        
        view.selectBlock = {[weak self] token in
            self?.assetArrow.tag = 0
            self?.showTokenView()
        }
        return view
    }()
    
}

extension IVWalletTransferVC{
   
    @objc func onclickShowToken(){
        self.assetArrow.tag = self.assetArrow.tag == 0 ? 1 : 0
        self.showTokenView()
    }
    
    func showTokenView(){
        if (self.assetArrow.tag == 1){
            self.selectTokenView.isHidden = false
        }
        self.assetArrow.superview?.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.assetArrow.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            if self.assetArrow.tag == 1{
                self.assetArrow.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                let height = self.selectTokenView.tokens.count > 3 ? 200.w : CGFloat(self.selectTokenView.tokens.count) * 60.w
                self.selectTokenView.snp.updateConstraints { make in
                    make.height.equalTo(height)
                }
            }else{
                self.assetArrow.transform = CGAffineTransform(rotationAngle: 0)
                self.selectTokenView.snp.updateConstraints { make in
                    make.height.equalTo(0.w)
                }
            }
            self.selectTokenView.superview?.layoutIfNeeded()
        } completion: { _ in
            self.assetArrow.superview?.isUserInteractionEnabled = true
            if (self.assetArrow.tag == 0){
                self.selectTokenView.isHidden = true
            }
        }
    }
    
    
    @objc func onclickAll(){
        
    }
    
    @objc func onclickConfirm(){
        
    }
    
}

extension IVWalletTransferVC{
    func getGas(){
//        viewModel.getGas(token: self.selectToken, toAddress: <#T##String#>)
    }
}
