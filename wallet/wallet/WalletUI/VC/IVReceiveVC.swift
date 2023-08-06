//
//  IVReceiveVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/8.
//

import UIKit
import EFQRCode


class IVReceiveVC: IVBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalReceive.localized
        self.createUI()
    }
    
    func createUI() {
        guard let address = Account.currentAccount?.address else{
            return
        }
        let ercodeImage = UIImageView()
        if let qrimage = EFQRCode.generate(for: address){
           ercodeImage.image = UIImage(cgImage: qrimage)
        }
        self.view.addSubview(ercodeImage)
        ercodeImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(132.h)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 266.w, height: 266.w))
        }
        
        let labTitle = UILabel.init(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.init(white: 1, alpha: 0.6),text: LocalScanReceive.localized)
        self.view.addSubview(labTitle)
        labTitle.snp.makeConstraints { make in
            make.top.equalTo(ercodeImage.snp.bottom).offset(50.w)
            make.left.equalToSuperview().offset(16.w)
        }
        
        let addressView = UIView(UIColor.init(white: 1, alpha: 0.08))
        addressView.dealLayer(corner: 8.w)
        self.view.addSubview(addressView)
        addressView.snp.makeConstraints { make in
            make.top.equalTo(labTitle.snp.bottom).offset(16.w)
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.height.equalTo(48.w)
        }
        
        let labAddress = UILabel.init(font: UIFont.TTTrialRegular(size: 15),textColor: UIColor.white,text: address.showAddress(11))
        addressView.addSubview(labAddress)
        labAddress.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16.w)
        }
        
        let btnCopy = UIButton.init(image: UIImage.init(named: "icon_wallet_copy"))
        btnCopy.addTarget(self, action: #selector(onclickCopy), for: .touchUpInside)
        addressView.addSubview(btnCopy)
        btnCopy.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(48.w)
        }
        
        let networkView = UIView(UIColor.init(white: 1, alpha: 0.08))
        networkView.dealLayer(corner: 8.w)
        self.view.addSubview(networkView)
        networkView.snp.makeConstraints { make in
            make.top.equalTo(addressView.snp.bottom).offset(16.w)
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
        }
        
        let labNetworkTitle = UILabel.init(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.init(white: 1, alpha: 0.6),text: LocalMainNetwork.localized)
        networkView.addSubview(labNetworkTitle)
        labNetworkTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.w)
            make.left.equalToSuperview().offset(16.w)
        }
        
        let labNetwork = UILabel.init(font: UIFont.TTTrialRegular(size: 15),textColor: UIColor.white,text: Account.currentAccount?.chain.chainName ?? "")
        networkView.addSubview(labNetwork)
        labNetwork.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16.w)
            make.top.equalTo(labNetworkTitle.snp.bottom).offset(12.w)
            make.left.equalToSuperview().offset(16.w)
        }
        
        let btnBottomCopy = UIButton.init(submitTite: LocalCopyAddress.localized)
        btnBottomCopy.addTarget(self, action: #selector(onclickCopy), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btnBottomCopy)
        btnBottomCopy.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-safeBottomH-10.w)
            make.size.equalTo(CGSize.init(width: 343.w, height: 50.w))
        }
        
    }
}

extension IVReceiveVC:PasteboardProtocol{
    @objc func onclickCopy(){
        pastWord(str: Account.currentAccount?.address ?? "")
    }
}
