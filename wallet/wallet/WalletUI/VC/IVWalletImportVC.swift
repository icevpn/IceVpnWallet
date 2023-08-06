//
//  IVWalletImportVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/12.
//

import UIKit

class IVWalletImportVC: IVBaseViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalImportWallet.localized
        self.addRightItem(UIImage(named: "icon_wallet_scan"))
        createUI()
    }
    
    func createUI(){
        let labTite = UILabel.init(font:UIFont.TTTrialBold(size: 16),textColor:UIColor.white,text:LocalMnemonicOrPrivateKey.localized)
        self.view.addSubview(labTite)
        labTite.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalToSuperview().offset(navHeight+16.w)
        }
        self.view.addSubview(textMnemoic)
        textMnemoic.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalTo(labTite.snp.bottom).offset(20.w)
            make.right.equalToSuperview().offset(-16.w)
            make.height.equalTo(200.w)
        }
        
        let labWalletName = UILabel.init(font:UIFont.TTTrialBold(size: 16),textColor:UIColor.white,text:LocalWalletName.localized)
        self.view.addSubview(labWalletName)
        labWalletName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalTo(textMnemoic.snp.bottom).offset(20.w)
        }
        self.view.addSubview(textWalletName)
        textWalletName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalTo(labWalletName.snp.bottom).offset(20.w)
            make.right.equalToSuperview().offset(16.w)
            make.height.equalTo(48.w)
        }
        
        let btnCreate = UIButton.init(submitTite: LocalConfirm.localized)
        btnCreate.addTarget(self, action: #selector(onclickConfirm), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btnCreate)
        btnCreate.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-safeBottomH-10.w)
            make.size.equalTo(CGSize.init(width: 343.w, height: 50.w))
        }
        
    }
    
    lazy var textMnemoic : UITextView = {
        let mnemonicText = UITextView()
        mnemonicText.backgroundColor = UIColor.init(white: 1, alpha: 0.08)
        mnemonicText.autocapitalizationType = .none
        mnemonicText.dealLayer(corner: 8.w)
        mnemonicText.text = LocalInputMnemonicAndSpace.localized
        mnemonicText.font = UIFont.Regular(size: 14)
        mnemonicText.textContainer.lineFragmentPadding = 0
        mnemonicText.keyboardType = .alphabet
        mnemonicText.textContainerInset = .zero
        mnemonicText.delegate = self
        mnemonicText.textColor = UIColor.init(white: 1, alpha: 0.6)
        mnemonicText.textContainerInset = UIEdgeInsets.init(top: 12.w, left: 12.w, bottom: 12.w, right: 12.w)
        return mnemonicText
    }()
    
    lazy var textWalletName : UITextField = {
        let text = UITextField.init("Wallet",font:UIFont.Regular(size: 14),textColor:UIColor.white)
        text.backgroundColor = UIColor.init(white: 1, alpha: 0.08)
        text.dealLayer(corner: 8.w)
        text.leftWidth(12.w)
        text.keyboardType = .asciiCapable
        text.delegate = self
        return text
    }()
}


extension IVWalletImportVC{
    
    @objc func onclickConfirm() {
        let mnemonics = textMnemoic.text.trimmingCharacters(in: .whitespaces)
        let dealTexts = mnemonics.components(separatedBy: " ")
        guard dealTexts.count == 12 else {
            self.createWithPrivateKey(mnemonics)
            return
        }
        self.createWithMnemonic(mnemonics)
    }
    
    func createWithMnemonic(_ mnemonics : String){
        let account = Account.init(mnemonic: mnemonics)
        if (account.address == ""){
            IVToast.toast(hit: LocalMnemonicError.localized)
            return
        }
        if (textWalletName.text?.count ?? 0) > 0{
            account.name = textWalletName.text!
        }
        IVRouter.to(name: .walletPassword,params: ["account":account])
    }
    
    func createWithPrivateKey(_ privateKey : String){
        let account = Account.init(privateKey: privateKey)
        if (account.address == ""){
            IVToast.toast(hit: LocalMnemonicOrPrivateKeyError.localized)
            return
        }
        if (textWalletName.text?.count ?? 0) > 0{
            account.name = textWalletName.text!
        }
        IVRouter.to(name: .walletPassword,params: ["account":account])
    }
}

extension IVWalletImportVC: UITextViewDelegate,UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == LocalInputMnemonicAndSpace.localized {
            textView.text = ""
            textView.textColor = UIColor.white
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.replacingOccurrences(of: " ", with: "") == "" {
            textView.text = LocalInputMnemonicAndSpace.localized
            textView.textColor = UIColor.init(white: 1, alpha: 0.6)
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension IVWalletImportVC{
    override func onRightAction() {
        IVRouter.to(name: .scan,params: ["vc" : self])
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textMnemoic.resignFirstResponder()
        self.textWalletName.resignFirstResponder()
    }
    
}

extension IVWalletImportVC : IVScanDelegate{
    func scanResult(result: String?) {
        self.textMnemoic.text = result
        if (result != nil){
            self.textMnemoic.textColor = UIColor.white
        }
    }
}
