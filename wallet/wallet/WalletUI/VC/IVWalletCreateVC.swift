//
//  IVWalletCreateVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/9.
//

import UIKit

class IVWalletCreateVC: IVBaseViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        // Do any additional setup after loading the view.
    }
    

    func createUI(){
        
        let btnConfirm = UIButton.init(submitTite: LocalAlertContinue.localized)
        btnConfirm.addTarget(self, action: #selector(onclickContinue), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btnConfirm)
        btnConfirm.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-safeBottomH-10.w)
            make.size.equalTo(CGSize.init(width: 343.w, height: 50.w))
        }
        
        let btnImport = UIButton(title: LocalImportWallet.localized,font: UIFont.TTTrialRegular(size: 14),color: UIColor.white,backgroundColor: color_7146FF06)
        btnImport.dealBorderLayer(corner: 6.w, bordercolor: color_A88EFF06, borderwidth: 1)
        btnImport.addTarget(self, action: #selector(onclickImport), for: .touchUpInside)
        self.view.addSubview(btnImport)
        btnImport.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(btnConfirm.snp.top).offset(-42.w)
            make.size.equalTo(CGSize(width: 178.w, height: 29.w))
        }
        
        let labTips = UILabel(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.init(white: 1, alpha: 0.6),text: LocalCreateTips.localized)
        labTips.textAlignment = .center
        labTips.numberOfLines = 0
        self.view.addSubview(labTips)
        labTips.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.w)
            make.right.equalToSuperview().offset(-20.w)
            make.bottom.equalTo(btnImport.snp.top).offset(-16.w)
        }
        
        let labTitle = UILabel(font: UIFont.TTTrialBold(size: 31),textColor: UIColor.white,text: LocalCreateWallet.localized)
        self.view.addSubview(labTitle)
        labTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(labTips.snp.top).offset(-16.w)
        }
        
        let icon = UIImageView(image: UIImage(named: "icon_wallet_create_bg"))
        self.view.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(labTitle.snp.top).offset(-160.w)
            make.size.equalTo(CGSize(width: 213.w, height: 223.w))
        }
        
        
        
        
        
        
        
        
    }

}

extension IVWalletCreateVC{
    @objc func onclickImport(){
        IVRouter.to(name: .walletImport)
    }
    
    @objc func onclickContinue(){
        IVRouter.to(name: .walletMnemonic)
    }
}

