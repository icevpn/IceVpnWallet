//
//  IVDappConfirmView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/1.
//

import UIKit

class IVDappConfirmView: UIView {
    var cancelBlock:(()->())?
    var nextBlock:(()->())?
    
    let backView = UIView(UIColor.white)
    convenience init(items : [IVDappConfirmModel],amount:String?,title:String) {
        self.init()
        self.createUI(items,amount: amount,title: title)
    }
    
    
    func createUI(_ items : [IVDappConfirmModel],amount:String?,title:String){
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        backView.dealCorner(type: .topLeftRight, corner: 20.w)
        self.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        let labTitle = UILabel.init(font: UIFont.Medium(size: 17),textColor: UIColor.black,text: title)
        backView.addSubview(labTitle)
        labTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24.w)
        }
        var topView : UIView = labTitle
        if (amount != nil){
            let labAmout = UILabel.init(font: UIFont.TTTrialBold(size: 30),textColor: UIColor.black,text: amount)
            backView.addSubview(labAmout)
            labAmout.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(topView.snp.bottom).offset(30.w)
            }
            topView = labAmout
        }
        
        items.forEach { item in
            let view = createItem(item)
            backView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.equalTo(topView.snp.bottom).offset(24.w)
                make.left.right.equalToSuperview()
            }
            topView = view
        }
        
        let btnConfirm = UIButton(title: LocalConfirm.localized,font: UIFont.TTTrialDemiBold(size: 17),color: UIColor.white)
        btnConfirm.addLeftTopToRightBottomGradient(colors: [color_AD01BA.cgColor,color_3A00F9.cgColor], size: CGSize(width: 334.w, height: 58.w), cornerRadius: 29.w)
        btnConfirm.addTarget(self, action: #selector(onclickConfirm), for: .touchUpInside)
        backView.addSubview(btnConfirm)
        btnConfirm.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(60.w)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 334.w, height: 58.w))
        }
        
        let btnCancel = UIButton(title: LocalCancle.localized,font: UIFont.TTTrialDemiBold(size: 14),color: UIColor.black)
        btnCancel.addTarget(self, action: #selector(onclickCancel), for: .touchUpInside)
        backView.addSubview(btnCancel)
        btnCancel.snp.makeConstraints { make in
            make.top.equalTo(btnConfirm.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 334.w, height: 58.w))
            make.bottom.equalToSuperview().offset(-safeBottomH-10.w)
        }
    }
    
    func createItem(_ item : IVDappConfirmModel) -> UIView{
        let view = UIView()
        let labTitle = UILabel.init(font: UIFont.Medium(size: 14),textColor: color_A5A5A5,text: item.title)
        view.addSubview(labTitle)
        labTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.w)
            make.top.equalToSuperview()
        }
        let labContent = UILabel.init(font: UIFont.TTTrialRegular(size: 12),textColor: color_A5A5A5,text: item.content)
        view.addSubview(labContent)
        labContent.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.w)
            make.top.equalTo(labTitle.snp.bottom).offset(6.w)
            make.bottom.equalToSuperview()
        }
        return view
    }
    
    
    @discardableResult
    class func show(items : [IVDappConfirmModel],amount:String?,title:String) -> IVDappConfirmView {
        let view = IVDappConfirmView(items: items,amount: amount,title: title)
        topWindow()?.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        animationAddView(view: view.backView)
        return view
    }

    @discardableResult
    func confirmAction(_ action: @escaping () -> Void) -> IVDappConfirmView {
        nextBlock = action
        return self
    }

    @discardableResult
    func cancelAction(_ action: @escaping () -> Void) -> IVDappConfirmView {
        cancelBlock = action
        return self
    }
    
}

extension IVDappConfirmView{
    @objc func onclickConfirm(){
        self.nextBlock?()
        animationRemoveview()
    }
    
    @objc func onclickCancel(){
        self.cancelBlock?()
        animationRemoveview()
    }
}
