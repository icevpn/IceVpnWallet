//
//  IVWalletSettingVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/16.
//

import UIKit

class IVWalletSettingVC: IVBaseViewController {
    var account = Account.currentAccount
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalManage.localized
        self.createUI()
    }
    
    func createUI(){
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(navHeight)
        }
        
        let btnLogout = UIButton(submitTite: LocalExitWallet.localized)
        btnLogout.addTarget(self, action: #selector(onclickLogout), for: .touchUpInside)
        self.view.addSubview(btnLogout)
        btnLogout.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.w, height: 50.w))
            make.bottom.equalToSuperview().offset(-safeBottomH-10.w)
        }
        
    }
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        if #available(iOS 15.0, *) {
            tableview.sectionHeaderTopPadding = 0
        }
        tableview.showsVerticalScrollIndicator = false
        tableview.contentInsetAdjustmentBehavior = .never
        tableview.backgroundColor = UIColor.clear
        tableview.separatorStyle = .none
        tableview.tableFooterView = UIView(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 15.w))
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(IVManageCell.self, forCellReuseIdentifier: "IVManageCell")
        return tableview
    }()
    
    lazy var datas : [IVManageModel] = {
        var data = [
            IVManageModel.init(title: LocalWalletName.localized, content: self.account?.name ?? "",type: .arrow,tag: .name),
            IVManageModel.init(title: LocalWalletAddress.localized, content: self.account?.address.showAddress() ?? "",type: .none,tag: .address),
            IVManageModel.init(title: LocalExportPrivateKey.localized,type: .arrow,tag: .privateKey),
            IVManageModel.init(title: LocalUpdatePassword.localized,type: .arrow,tag: .updatePassword),
            IVManageModel.init(title: LocalForgetPassword.localized,type: .arrow,tag: .forgetPassword)]
        if account?.mnemonic != ""{
            data.insert(IVManageModel.init(title: LocalExportMnemonic.localized,type: .arrow,tag: .mnemonic), at: 2)
        }
        return data
    }()
}

extension IVWalletSettingVC{
    @objc func onclickLogout(){
        IVAlert.alert(.tip)
            .title(LocalOutPutPrompt.localized)
            .confirm(LocalAlertContinue.localized)
            .cancel(LocalAlertCancel.localized)
            .popup()
            .confirmAction { [weak self] in
                IVPasswordAlert.show(password: WalletManager.shared.password ?? "").confirmAction {
                    Account.currentAccount = nil
                    self?.popToRoot()
                }
            }
    }
}

extension IVWalletSettingVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.w
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IVManageCell", for: indexPath) as! IVManageCell
        cell.model = self.datas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.datas[indexPath.row]
        if model.tag == .name{
            IVInputAlert().title(LocalSetWalletName.localized).confirmAction {[weak self] value in
                self?.account?.name = value
                self?.datas[0] = IVManageModel.init(title: LocalWalletName.localized, content: self?.account?.name ?? "",type: .arrow,tag: .name)
                Account.currentAccount = self?.account
                self?.tableView.reloadData()
            }.popup()
            return
        }
        
        if model.tag == .updatePassword{
            IVRouter.to(name: .walletUpdatePassword)
            return
        }
        
        if model.tag == .forgetPassword{
            IVRouter.to(name: .walletForgetPassword)
            return
        }
        
        if model.tag == .mnemonic{
            IVPasswordAlert.show(password: WalletManager.shared.password ?? "").confirmAction {
                IVRouter.to(name: .walletExport)
            }
            return
        }
        
        if model.tag == .privateKey{
            IVPasswordAlert.show(password: WalletManager.shared.password ?? "").confirmAction {
                IVRouter.to(name: .exportPrivateKey)
            }
            
            return
        }
    }
}
