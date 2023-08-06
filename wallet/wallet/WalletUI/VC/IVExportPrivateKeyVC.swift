//
//  IVExportPrivateKeyVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/25.
//

import UIKit
import EFQRCode

class IVExportPrivateKeyVC: IVBaseViewController ,PasteboardProtocol{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalExportPrivateKey.localized
        createUI()
    }
    
    func createUI() {
        
        let labTips = UILabel(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.init(white: 1, alpha: 0.6),text: LocalExportPrivateKeyTips.localized)
        labTips.numberOfLines = 0
        self.view.addSubview(labTips)
        labTips.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.top.equalToSuperview().offset(16.w + navHeight)
        }
        
        guard let model = Account.currentAccount else{
            return
        }
        
        let ercodeImage = UIImageView()
        if let qrimage = EFQRCode.generate(for: model.privateKey){
           ercodeImage.image = UIImage(cgImage: qrimage)
        }
        self.view.addSubview(ercodeImage)
        ercodeImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labTips.snp.bottom).offset(20.w)
            make.size.equalTo(CGSize(width: 200.w, height: 200.w))
        }
        
        let privateKeyView = UIView(UIColor(white: 1, alpha: 0.08))
        privateKeyView.dealLayer(corner: 8.w)
        self.view.addSubview(privateKeyView)
        privateKeyView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ercodeImage.snp.bottom).offset(50.w)
            make.width.equalTo(343.w)
        }
        
        let labKey = UILabel(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.white,text: model.privateKey)
        labKey.numberOfLines = 0
        privateKeyView.addSubview(labKey)
        labKey.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16.w, left: 16.w, bottom: 16.w, right: 16.w))
        }
        
        let btnSubmit = UIButton(submitTite: LocalCopy.localized)
        btnSubmit.addTarget(self, action: #selector(onclickCopy), for: .touchUpInside)
        self.view.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-safeBottomH-10.w)
            make.size.equalTo(CGSize(width: 343.w, height: 50.w))
        }
    }
    
    
    @objc func onclickCopy() {
        guard let model = Account.currentAccount else{
            return
        }
        pastWord(str: model.privateKey)
    }
}
