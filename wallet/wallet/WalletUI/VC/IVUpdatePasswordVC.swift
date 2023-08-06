//
//  IVUpdatePasswordVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/18.
//

import UIKit

class IVUpdatePasswordVC: IVBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalUpdatePassword.localized
//        self.addRightItem("Forget")
        createUI()
    }
    
    func createUI() {
        let labCurrentPassword = UILabel.init(font:UIFont.Bold(size: 14),textColor:UIColor.white,text:LocalCurrentPassword.localized)
        self.view.addSubview(labCurrentPassword)
        labCurrentPassword.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalToSuperview().offset(navHeight + 28.w)
        }
        self.view.addSubview(textCurrentPassword)
        textCurrentPassword.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalTo(labCurrentPassword.snp.bottom).offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.height.equalTo(48.w)
        }
        
        self.view.addSubview(btnCurrentPassword)
        btnCurrentPassword.snp.makeConstraints { make in
            make.right.top.bottom.equalTo(textCurrentPassword)
            make.width.equalTo(46.w)
        }
        
        let labNewPassword = UILabel.init(font:UIFont.Bold(size: 14),textColor:UIColor.white,text:LocalNewPassword.localized)
        self.view.addSubview(labNewPassword)
        labNewPassword.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalTo(textCurrentPassword.snp.bottom).offset(25.w)
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
        
        let labEnsurePassword = UILabel.init(font:UIFont.Bold(size: 14),textColor:UIColor.white,text:LocalConfirmPassword.localized)
        self.view.addSubview(labEnsurePassword)
        labEnsurePassword.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalTo(textNewPassword.snp.bottom).offset(25.w)
        }
        
        self.view.addSubview(textConfirmPassword)
        textConfirmPassword.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalTo(labEnsurePassword.snp.bottom).offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.height.equalTo(48.w)
        }
        
        self.view.addSubview(btnConfirmPassword)
        btnConfirmPassword.snp.makeConstraints { make in
            make.right.top.bottom.equalTo(textConfirmPassword)
            make.width.equalTo(46.w)
        }
        
        
        self.view.addSubview(self.saveBtn)
        self.saveBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-safeBottomH-10.w)
            make.size.equalTo(CGSize(width: 343.w, height: 50.w))
        }
    }
    
    lazy var textCurrentPassword : UITextField = {
        let text = UITextField.init(LocalLoginPasswordDesc.localized,font:UIFont.Medium(size: 13),textColor:UIColor.white)
        text.backgroundColor = UIColor.init(white: 1, alpha: 0.08)
        text.dealLayer(corner: 8.w)
        text.leftWidth(16.w)
        text.keyboardType = .numberPad
        text.delegate = self
        text.isSecureTextEntry = true
        return text
    }()
    
    lazy var btnCurrentPassword : UIButton = {
        let btn = UIButton.init(image: UIImage(named: "icon_eyes_open"),selectImage: UIImage(named: "icon_eyes_close"))
        btn.addTarget(self, action: #selector(onclickCurrentPassword), for: .touchUpInside)
        return btn
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
    
    
    lazy var textConfirmPassword : UITextField = {
        let text = UITextField.init(LocalLoginPasswordDesc.localized,font:UIFont.Medium(size: 13),textColor:UIColor.white)
        text.backgroundColor = UIColor.init(white: 1, alpha: 0.08)
        text.dealLayer(corner: 8.w)
        text.leftWidth(16.w)
        text.keyboardType = .numberPad
        text.delegate = self
        text.isSecureTextEntry = true
        return text
    }()

    lazy var btnConfirmPassword : UIButton = {
        let btn = UIButton.init(image: UIImage(named: "icon_eyes_open"),selectImage: UIImage(named: "icon_eyes_close"))
        btn.addTarget(self, action: #selector(onclickConfirmPassword), for: .touchUpInside)
        return btn
    }()
    
    lazy var saveBtn : UIButton = {
        let btn = UIButton.init(submitTite: LocalConfirm.localized)
        btn.addTarget(self, action: #selector(onclickSave), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
}

extension IVUpdatePasswordVC{
    @objc func onclickSave() {
        guard checkInputMessage() else {
            return
        }
        WalletManager.shared.password = self.textNewPassword.text
        IVToast.toast(hit: LocalPasswordUpdateSuccess.localized)
        popPage()
    }
    
    //检查
    func checkInputMessage() -> Bool {
        guard let currentPassword = self.textCurrentPassword.text?.removeSpace(), currentPassword.count == 6 else{
            IVToast.toast(hit: LocalWalletPasswordFormatError.localized)
            return false
        }
        
        let password = WalletCrypto.md5Encrypt(value: currentPassword)
        if (password != WalletManager.shared.password){
            IVToast.toast(hit: LocalPasswordError.localized)
            return false
        }
        
        guard let newPassword = self.textNewPassword.text?.removeSpace(),newPassword.count == 6 else{
            IVToast.toast(hit: LocalWalletPasswordFormatError.localized)
            return false
        }
        guard let confirmPassword = self.textConfirmPassword.text?.removeSpace(),confirmPassword.count == 6 else{
            IVToast.toast(hit: LocalWalletPasswordFormatError.localized)
            return false
        }
        if (newPassword != confirmPassword){
            IVToast.toast(hit: LocalDifferentPassword.localized)
            return false
        }
        
        return true
    }
    
//    override func onRightAction() {
//        IVRouter.to(name: .walletForgetPassword)
//    }
}

extension IVUpdatePasswordVC{
    @objc func onclickCurrentPassword(){
        self.textCurrentPassword.isSecureTextEntry = !(self.btnCurrentPassword.isSelected)
    }
    
    @objc func onclickNewPassword(){
        self.textCurrentPassword.isSecureTextEntry = !(self.btnCurrentPassword.isSelected)
    }
    
    @objc func onclickConfirmPassword(){
        self.textCurrentPassword.isSecureTextEntry = !(self.btnCurrentPassword.isSelected)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textNewPassword.resignFirstResponder()
        textCurrentPassword.resignFirstResponder()
        textConfirmPassword.resignFirstResponder()
    }
}

extension IVUpdatePasswordVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count ?? 0 < 6 || string == ""{
            return true
        }

        textField.resignFirstResponder()
        return false
    }
}
