//
//  IVWalletSendVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/8.
//

import UIKit
import SDWebImage
class IVWalletSendVC: IVBaseViewController {
    
    let account = Account.currentAccount
    
    var gas : IVGasModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalSendTo.localized
        self.createUI()
        self.getBalance()
        self.getGasPrice()
    }
    
    func createUI() {
        
        let addressView = UIView(UIColor(white: 1, alpha: 0.08))
        addressView.dealLayer(corner: 8.w)
        self.view.addSubview(addressView)
        addressView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.w + navHeight)
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
        }
        
        let labFormTitile = UILabel.init(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.init(white: 1, alpha: 0.6),text: "From")
        addressView.addSubview(labFormTitile)
        labFormTitile.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.w)
            make.left.equalToSuperview().offset(16.w)
        }
        
        let labFormAddress = UILabel.init(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.white,text: account?.address.showAddress())
        addressView.addSubview(labFormAddress)
        labFormAddress.snp.makeConstraints { make in
            make.top.equalTo(labFormTitile.snp.bottom).offset(10.w)
            make.left.equalToSuperview().offset(16.w)
        }
        
        let line = UIView(color_CACACA)
        addressView.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(labFormAddress.snp.bottom).offset(8.w)
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.height.equalTo(0.5)
        }
        
        let labAddressTitile = UILabel.init(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.init(white: 1, alpha: 0.6),text: "To")
        addressView.addSubview(labAddressTitile)
        labAddressTitile.snp.makeConstraints { make in
            make.top.equalTo(line).offset(10.w)
            make.left.equalToSuperview().offset(16.w)
        }
        
        addressView.addSubview(textAddress)
        textAddress.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalTo(labAddressTitile.snp.bottom)
            make.right.equalToSuperview().offset(-50.w)
            make.bottom.equalToSuperview().offset(-15.w)
            make.height.equalTo(40.w)
        }
        
        let btnScan = UIButton.init(image: UIImage.init(named: "icon_wallet_scan"))
        btnScan.addTarget(self, action: #selector(onclickScan), for: .touchUpInside)
        addressView.addSubview(btnScan)
        btnScan.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(textAddress)
            make.width.height.equalTo(48.w)
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
        
        let labNetwork = UILabel.init(font: UIFont.TTTrialRegular(size: 15),textColor: UIColor.white,text: self.account?.chain.chainName ?? "")
        networkView.addSubview(labNetwork)
        labNetwork.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16.w)
            make.top.equalTo(labNetworkTitle.snp.bottom).offset(12.w)
            make.left.equalToSuperview().offset(16.w)
        }
        
        let amountView = UIView(UIColor.init(white: 1, alpha: 0.08))
        amountView.dealLayer(corner: 8.w)
        self.view.addSubview(amountView)
        amountView.snp.makeConstraints { make in
            make.top.equalTo(networkView.snp.bottom).offset(16.w)
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
        }
        
        let labAmountTitile = UILabel.init(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.init(white: 1, alpha: 0.6),text: LocalAmount.localized)
        amountView.addSubview(labAmountTitile)
        labAmountTitile.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.w)
            make.left.equalToSuperview().offset(16.w)
        }
    
        let iconArrow = UIImageView(image: UIImage(named: "icon_right_arrow")?.withRenderingMode(.alwaysTemplate))
        iconArrow.isUserInteractionEnabled = true
        iconArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeToken)))
        iconArrow.tintColor = UIColor.white
        amountView.addSubview(iconArrow)
        iconArrow.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.w)
            make.centerY.equalTo(labAmountTitile)
        }
        
        amountView.addSubview(labSymbol)
        labSymbol.snp.makeConstraints { make in
            make.right.equalTo(iconArrow.snp.left).offset(-5.w)
            make.centerY.equalTo(labAmountTitile)
        }
        
        amountView.addSubview(textAmount)
        textAmount.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalTo(labAmountTitile.snp.bottom)
            make.right.equalToSuperview().offset(-50.w)
            make.bottom.equalToSuperview().offset(-15.w)
            make.height.equalTo(40.w)
        }
        
        
        
        self.view.addSubview(self.gasView)
        self.gasView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(amountView.snp.bottom).offset(16.w)
        }
        
        
        let btnAll = UIButton.init(title: LocalAll.localized,font: UIFont.TTTrialBold(size: 14),color: UIColor.white)
        btnAll.addTarget(self, action: #selector(onclickAll), for: .touchUpInside)
        amountView.addSubview(btnAll)
        btnAll.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(textAmount)
            make.width.height.equalTo(48.w)
        }
        
        let btnConfirm = UIButton.init(title:LocalConfirm.localized,font: UIFont.TTTrialBold(size: 17),color: UIColor.white)
        btnConfirm.addTarget(self, action: #selector(onclickConfirm), for: UIControl.Event.touchUpInside)
        btnConfirm.addLeftTopToRightBottomGradient(colors: [color_AD01BA.cgColor,color_3A00F9.cgColor], size: CGSize(width: 343.w, height: 51.w), cornerRadius: 25.w)
        self.view.addSubview(btnConfirm)
        btnConfirm.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-safeBottomH-10.w)
            make.size.equalTo(CGSize.init(width: 343.w, height: 50.w))
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textAmount.resignFirstResponder()
        textAddress.resignFirstResponder()
    }
    
    
    lazy var selectToken : Token = {
        let token = account?.mainToken ?? Token()
        return token
    }()
    
    lazy var textAddress : UITextField = {
        let text = UITextField(LocalReceiveAddress.localized,font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.white)
        text.delegate = self
        return text
    }()
    
    lazy var textAmount : UITextField = {
        let text = UITextField("0.0",font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.white)
        text.keyboardType = .decimalPad
        return text
    }()
    
    lazy var labSymbol : UILabel = {
        let labSymbol = UILabel.init(font: UIFont.TTTrialMedium(size: 14),textColor: UIColor.white)
        labSymbol.isUserInteractionEnabled = true
        labSymbol.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeToken)))
        return labSymbol
    }()
    
    lazy var gasView : IVGasView = {
        let gasView = IVGasView(chain: self.account!.chain)
        return gasView
    }()
}

extension IVWalletSendVC{
    func updateUI(){
        
    }
    
    @objc func onclickScan(){
        IVRouter.to(name: .scan,params: ["vc" : self])
    }
    
    @objc func onclickAll(){
        if self.textAddress.text?.count ?? 0 == 0{
            IVToast.toast(hit: LocalInputReceiveAddress.localized)
            return
        }
        
        if self.selectToken.address != ""{
            self.textAmount.text = self.selectToken.balance
            return
        }
        
        if self.gas == nil || self.gas?.gasLimit == ""{
            getGas()
            IVToast.toast(hit: LocalDidNotGetFee.localized)
            return
        }
        self.textAmount.text = self.selectToken.balance.reduction(numberString: gas!.gas)
    }
    
    @objc func onclickConfirm(){
        guard let address = self.textAddress.text else{
            return
        }
        guard let amount = self.textAmount.text else{
            return
        }
        guard let gas = self.gas else{
            getGas()
            IVToast.toast(hit: LocalDidNotGetFee.localized)
            return
        }
        IVDappConfirmView.show(items: [
            IVDappConfirmModel.init(title: LocalSendAddress.localized, content: self.account?.address ?? ""),
            IVDappConfirmModel.init(title: LocalReviceAddress.localized, content: address),
            IVDappConfirmModel.init(title: "Gas Price", content: "\(gas.gas) \(account?.mainToken?.symbol ?? "")")], amount: "\(self.textAmount.text ?? "") \(selectToken.symbol)", title: "Transfer Info")
        .confirmAction {
            IVPasswordAlert.show(password: WalletManager.shared.password ?? "")
                .confirmAction {[weak self] in
                self?.send(address: address, amount: amount)
            }
        }
    }
    
    func send(address : String,amount : String){
        Task{
            do {
                IVToast.loding()
                let result = try await IVTransferController.send(toAddress: address, num: amount, token: selectToken)
                if result != nil{
                    IVAlert.alert(.success)
                        .title(LocalTransferSuccess.localized)
                        .confirm(LocalConfirm.localized)
                        .popup()
                    getBalance()
                    self.textAmount.text = ""
                }
                IVToast.hideLoding()
            }catch let error as WalletError{
                IVToast.toast(hit: error.errorDescription)
                IVToast.hideLoding()
            }catch{
                IVToast.toast(hit: error.localizedDescription)
                IVToast.hideLoding()
            }
        }
    }
    
    @objc func changeToken() {
        let vc = IVWalletSelectTokenVC()
        vc.selectBlock = {[weak self] token in
            self?.selectToken = token
            self?.getBalance()
            self?.updateUI()
        }
        self.present(vc, animated: true)
    }
}

extension IVWalletSendVC : IVScanDelegate,UITextFieldDelegate{
    func scanResult(result: String?) {
        self.textAddress.text = result
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == self.textAddress){
            getGas()
        }
    }
}

extension IVWalletSendVC{
    
    func getGasPrice() {
        Task{
            guard let gasPrice = await gasRequest(account: self.account!).request() else{
                return
            }
            self.gas = IVGasModel(gasPrice: "\(gasPrice)")
            self.gasView.gas = self.gas
        }
    }
    
    func getGas(){
        guard let address = self.textAddress.text else{
            return
        }
        Task{
            do{
                self.gas = try await IVTransferController.getGas(token: self.selectToken, toAddress: address)
            }catch let error as WalletError{
                IVToast.toast(hit: error.errorDescription)
            }catch{
                IVToast.toast(hit: error.localizedDescription)
                
            }
        }
    }
    
    func getBalance(){
        guard let account = self.account else{
            return
        }
        Task{
            await self.selectToken.getBalance(account:account)
            self.labSymbol.text = "\(self.selectToken.symbol) \(self.selectToken.balance)"
        }
    }
    
}
