//
//  IVWalletVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/7.
//

import UIKit

class IVWalletVC: IVRefreshControl {
    
    var model : Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalWallet.localized
        self.createUI()
        self.getNFTs()
    }
    
    func createUI(){
        setRefreshView(self.mainView.collectionView)
        self.view.addSubview(self.mainView)
        mainView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(navHeight)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    lazy var mainView : IVWalletMainView = {
        let mainView = IVWalletMainView(frame: CGRect.zero)
        mainView.model = self.model
        mainView.changChainBlock = {
            IVRouter.to(name: .walletChain,params: ["vc":self])
        }
        mainView.manageBlock = {
            IVRouter.to(name: .walletSetting)
        }
        return mainView
    }()
    
    override func popPage() {
        self.popToRoot()
    }
}

extension IVWalletVC{
    override func refressh() {
        self.getData()
    }
    
    
    func getData(){
        getNFTContrart()
        guard let model = Account.currentAccount else{
            return
        }
        self.model = model
        self.mainView.model = self.model
        if mainView.isNFT {
            getNFTs()
            return
        }
        getBalance()
        
    }
    
    func getBalance() {
        Task{
            await self.model?.getAllBalance()
            Account.currentAccount = self.model
            self.mainView.model = self.model
            self.endRefreshing()
        }
    }
    
    func getNFTs() {
        Task{
            await self.model?.getNFTs()
            Account.currentAccount = self.model
            self.mainView.model = self.model
            self.endRefreshing()
        }
    }
    
    func getNFTContrart() {
        if (AppConfigController.shared.nftContrart != nil){
            return
        }
        Task{
            await AppConfigController.shared.getNFTContrart()
            self.mainView.collectionView.reloadData()
        }
    }
}

extension IVWalletVC : IVWalletChainDelegate{
    func walletCainUpdate(chain: Chain) {
        self.model?.changeChain(chain)
        Account.currentAccount = self.model
        self.mainView.model = self.model
        getBalance()
    }
}
