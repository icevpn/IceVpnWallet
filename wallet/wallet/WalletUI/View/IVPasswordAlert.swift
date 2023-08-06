//
//  IVPasswordAlert.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/6.
//

import UIKit

class IVPasswordAlert: UIView {
    let backView = UIView(UIColor.white)
    var succressBlock : (()->())?
    var cancelBlock: (()->())?
    var password = ""
    
    convenience init(password : String) {
        self.init()
        self.password = password
        self.createUI()
    }
    
    
    func createUI(){
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        backView.dealLayer(corner: 10.w)
        self.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50.w)
            make.left.equalToSuperview().offset(25.w)
            make.right.equalToSuperview().offset(-25.w)
        }
        let labTitle = UILabel.init(font: UIFont.Bold(size: 17),textColor: UIColor.black,text: LocalPayPassword.localized)
        backView.addSubview(labTitle)
        labTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24.w)
        }
        
        backView.addSubview(passwordView)
        passwordView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50.w)
            make.top.equalTo(labTitle.snp.bottom).offset(25.w)
        }
        
        let btnCancel = UIButton(title: LocalCancle.localized,font: UIFont.Medium(size: 17),color: color_979797)
        btnCancel.addTarget(self, action: #selector(onclickCancel), for: .touchUpInside)
        backView.addSubview(btnCancel)
        btnCancel.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(55.w)
            make.bottom.equalToSuperview()
        }
        
        let btnSubmit = UIButton(title: LocalConfirm.localized,font: UIFont.Medium(size: 17),color: color_7146FF)
        btnSubmit.addTarget(self, action: #selector(onclickSubmit), for: .touchUpInside)
        backView.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints { make in
            make.centerY.equalTo(btnCancel)
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(55.w)
        }
        
        
    }
    
    
    lazy var passwordView : IVPasswordInputView = {
        let view = IVPasswordInputView.init(config: IVPasswordConfig(color: color_979797,width: 40.w,height: 45.w,left: 16.w,square: 10.w,borderColor: color_979797))
        view.keyboardType = UIKeyboardType.numberPad
        view.inputDoneBlock = {[weak self] in
            self?.onclickSubmit()
            
        }
        return view
    }()
    
    @discardableResult
    class func show(password : String) -> IVPasswordAlert {
        let view = IVPasswordAlert(password: password)
        topWindow()?.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        animationAddView(view: view.backView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            view.passwordView.becomeFirstResponder()
        })
        return view
    }
    
    @discardableResult
    func confirmAction(_ action: @escaping () -> Void) -> IVPasswordAlert {
        succressBlock = action
        return self
    }

    @discardableResult
    func cancelAction(_ action: @escaping () -> Void) -> IVPasswordAlert {
        cancelBlock = action
        return self
    }
}


extension IVPasswordAlert{
    @objc func onclickCancel(){
        self.passwordView.resignFirstResponder()
        self.cancelBlock?()
        animationRemoveview()
    }
    
    @objc func onclickSubmit(){
        let inputValue = WalletCrypto.md5Encrypt(value: self.passwordView.passwords.joined())
        if (self.password != inputValue){
            self.passwordView.clean()
            IVToast.toast(hit: LocalPasswordError.localized)
            let impactLight = UIImpactFeedbackGenerator(style: .rigid)
            impactLight.impactOccurred()
        }else{
            self.passwordView.resignFirstResponder()
            self.succressBlock?()
            animationRemoveview()
        }
    }
}
