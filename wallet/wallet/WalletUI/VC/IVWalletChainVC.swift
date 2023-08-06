//
//  IVWalletChainVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/13.
//

import UIKit

protocol IVWalletChainDelegate{
    func walletCainUpdate(chain : Chain)
}

class IVWalletChainVC: IVBaseViewController {
    var delegate : IVWalletChainDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Network switch"
        createUI()
    }
    
    func createUI(){
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(navHeight)
        }
    }
    
    lazy var dataArr : [Chain] = {
        let arr = WalletConfig.shared.chains ?? WalletConfig.shared.getChains()
        return arr
    }()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .grouped)
        tableview.delegate = self
        tableview.dataSource = self
        if #available(iOS 15.0, *) {
            tableview.sectionHeaderTopPadding = 0
        }
        tableview.showsVerticalScrollIndicator = false
        tableview.contentInsetAdjustmentBehavior = .never
        tableview.backgroundColor = UIColor.clear
        tableview.separatorStyle = .none
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(IVWalletChainCell.self, forCellReuseIdentifier: "IVWalletChainCell")
        return tableview
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension IVWalletChainVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71.w
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IVWalletChainCell", for: indexPath) as! IVWalletChainCell
        cell.model = self.dataArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.selectBlock?(self.dataArr[indexPath.row])
        self.delegate?.walletCainUpdate(chain: self.dataArr[indexPath.row])
        popPage()
    }
}
