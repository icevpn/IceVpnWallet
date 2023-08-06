//
//  IVForgetPasswordVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/18.
//

import UIKit

class IVForgetPasswordVC: IVBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalForgetPassword.localized
        createUI()
    }
    
    
    func createUI() {
        self.view.addSubview(self.textView)
        self.textView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.height.equalTo(150.w)
            make.top.equalToSuperview().offset(navHeight + 28.w)
        }
        
        let labNewPassword = UILabel.init(font:UIFont.Bold(size: 14),textColor:UIColor.white,text:LocalNewPassword.localized)
        self.view.addSubview(labNewPassword)
        labNewPassword.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(textView.snp.bottom).offset(25.w)
        }
        self.view.addSubview(textNewPassword)
        textNewPassword.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalTo(labNewPassword.snp.bottom).offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.height.equalTo(48.w)
        }
        
        self.view.addSubview(btnNewPassword)
        btnNewPassword.snp.makeConstraints { make in
            make.right.top.bottom.equalTo(textNewPassword)
            make.width.equalTo(46.w)
        }
        
        let btnSubmit = UIButton(submitTite: LocalConfirm.localized)
        btnSubmit.addTarget(self, action: #selector(onclickSubmit), for: .touchUpInside)
        self.view.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-safeBottomH-10.w)
            make.size.equalTo(CGSize(width: 343.w, height: 50.w))
        }
    }
    
    lazy var textView : UITextView = {
        let text = UITextView.init(UIColor(white: 1, alpha: 0.08))
        text.delegate = self
        text.textColor = UIColor(white: 1, alpha: 0.6)
        text.text = LocalInputMnemonicAndSpace.localized
        text.dealLayer(corner: 8.w)
        text.textContainer.lineFragmentPadding = 0.0
        text.textContainerInset = UIEdgeInsets.init(top: 16.w, left: 16.w, bottom: 16.w, right: 16.w)
        text.font = UIFont.Medium(size: 14)
        return text
    }()
    
    lazy var textNewPassword : UITextField = {
        let text = UITextField.init(LocalLoginPasswordDesc.localized,font:UIFont.Medium(size: 13),textColor:UIColor.white)
        text.backgroundColor = UIColor.init(white: 1, alpha: 0.08)
        text.dealLayer(corner: 8.w)
        text.leftWidth(16.w)
        text.keyboardType = .numberPad
        text.delegate = self
        text.isSecureTextEntry = true
        return text
    }()
    
    lazy var btnNewPassword : UIButton = {
        let btn = UIButton.init(image: UIImage(named: "icon_eyes_open"),selectImage: UIImage(named: "icon_eyes_close"))
        btn.addTarget(self, action: #selector(onclickNewPassword), for: .touchUpInside)
        return btn
    }()
    
}



extension IVForgetPasswordVC : UITextViewDelegate,UITextFieldDelegate{

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
            textView.textColor = UIColor(white: 1, alpha: 0.6)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count ?? 0 < 6 || string == ""{
            return true
        }
        textField.resignFirstResponder()
        return false
    }
}


extension IVForgetPasswordVC{
    @objc func onclickSubmit(){
        guard let newPassword = self.textNewPassword.text?.removeSpace(),newPassword.count == 6 else{
            IVToast.toast(hit: LocalWalletPasswordFormatError.localized)
            return
        }
        guard let inputMnemonic = self.textView.text?.replacingOccurrences(of: " ", with: "") else{
            return
        }
        
        
        if !verification(value: inputMnemonic){
            return
        }
        
        WalletManager.shared.password = newPassword
        popPage()
    }
    
    
    func verification(value : String) -> Bool{
        guard let wallet = Account.currentAccount else{
            return false
        }
        if (wallet.mnemonic.replacingOccurrences(of: " ", with: "").lowercased() == value.lowercased()){
            return true
        }
        if (wallet.privateKey.replacingOccurrences(of: " ", with: "").lowercased() == value.lowercased()){
            return true
        }
        IVToast.toast(hit: LocalMenmonicValidationFail.localized)
        return false
    }
    
    
    @objc func onclickNewPassword(){
        
    }
    
    
}
