//
//  IVPasswordVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/30.
//

import UIKit

class IVPasswordVC: IVBaseViewController {
    var account : Account?
    var isCreate = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = isCreate ? LocaConfimPassword.localized : LocalWalletPasswprd.localized
        self.createUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.passwordInputView.becomeFirstResponder()
    }
    
    private func createUI(){
        self.view.addSubview(passwordInputView)
        passwordInputView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(9.w)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(100.w)
        }
    }
    
    lazy var passwordInputView : IVPasswordInputView = {
        let view = IVPasswordInputView.init(config: IVPasswordConfig())
        view.inputDoneBlock = {[weak self] in
            
            if self?.isCreate == false{
                IVRouter.to(name: .walletPassword,params: ["account":self?.account,"isCreate" : true])
                WalletManager.shared.password = self?.passwordInputView.passwords.joined()
                return
            }
            
            let password = self?.passwordInputView.passwords.joined() ?? ""
            
            if WalletCrypto.md5Encrypt(value: password) != WalletManager.shared.password{
                self?.passwordInputView.clean()
                IVToast.toast(hit: LocalDifferentPassword.localized)
                return
            }
            Account.currentAccount = self?.account
            WalletManager.shared.password = password
            IVRouter.to(name: .walletMain)
        }
        return view
    }()
    
    
}
