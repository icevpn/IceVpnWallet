//
//  IVWalletBackupVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/12.
//

import UIKit

class IVWalletBackupVC: IVBaseViewController {
    var walletName : String?
    
    var mnemonics : [String] = []
    var selectMnemonics : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalBackupMnemonic.localized
        createUI()
    }
    
    func createUI(){
        
        let scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.dealLayer(corner: 0)
        scrollView.contentSize = CGSize(width: Screen_width, height: 800.w)
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(navHeight)
        }

        let labTips = UILabel.init(font: UIFont.TTTrialRegular(size: 13),textColor: UIColor.white,text: LocalBackupMnemonicTips1.localized)
        labTips.numberOfLines = 0
        scrollView.addSubview(labTips)
        labTips.snp.makeConstraints { make in
            make.left.equalTo(self.view).offset(16.w)
            make.right.equalTo(self.view).offset(-16.w)
            make.top.equalToSuperview().offset(28.w)
        }
        
        scrollView.addSubview(mnemonicView)
        mnemonicView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labTips.snp.bottom).offset(20.w)
            make.size.equalTo(CGSize.init(width: 343.w, height: 267.w))
        }
        
        scrollView.addSubview(self.showMnemonicView)
        showMnemonicView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mnemonicView.snp.bottom).offset(10.w)
            make.size.equalTo(CGSize.init(width: 343.w, height: 267.w))
        }
        
        
        
        let btnContinue = UIButton.init(submitTite: LocalAlertContinue.localized)
        btnContinue.addTarget(self, action: #selector(onclickContinue), for: UIControl.Event.touchUpInside)
        scrollView.addSubview(btnContinue)
        btnContinue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(showMnemonicView.snp.bottom).offset(50.w)
            make.size.equalTo(CGSize.init(width: 343.w, height: 50.w))
        }
    }
    
    lazy var mnemonicView : IVMnemonicView = {
        let view = IVMnemonicView(mnemonic : self.selectMnemonics)
        view.clickBlock =  {[weak self] (index,_) in
            self?.selectMnemonics.remove(at: index)
            self?.mnemonicView.updateMnemonic(mnemonic: self?.selectMnemonics ?? [])
        }
        return view
    }()
    
    lazy var showMnemonicView : IVMnemonicView = {
        let view = IVMnemonicView(mnemonic : (self.mnemonics.getRandomAry() as! [String]),isGradine: false)
        view.clickBlock = {[weak self] (_,value) in
            
            if self?.selectMnemonics.contains(value) == true{
                return
            }
            self?.selectMnemonics.append(value)
            self?.mnemonicView.updateMnemonic(mnemonic: self?.selectMnemonics ?? [])
            self?.showMnemonicView.updateSelectMnemonic(mnemonic: self?.selectMnemonics ?? [])
        }
        return view
    }()
    
}

extension IVWalletBackupVC{
    @objc func onclickContinue() {
        if verification() == false{
            return
        }
        let account = Account.init(mnemonic: self.mnemonics.joined(separator: " "))
        
        IVRouter.to(name: .walletPassword,params: ["account":account])
    }
    
    private func verification() -> Bool{
        if self.mnemonicView.mnemonic?.count ?? 0 < 12{
            return false
        }
        if self.mnemonicView.mnemonic?.joined() != self.mnemonics.joined(){
            IVToast.toast(hit: LocalMenmonicValidationFail.localized)
            return false
        }
        return true
    }
    
}

