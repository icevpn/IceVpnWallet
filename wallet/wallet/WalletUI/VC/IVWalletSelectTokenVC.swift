//
//  IVWalletSelectTokenVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/8.
//

import UIKit

class IVWalletSelectTokenVC: IVBaseViewController {
    
    var selectBlock:((Token)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    func createUI(){
        let labTitle = UILabel.init(font: UIFont.Bold(size: 17),textColor: UIColor.white,text: "Select Token")
        self.view.addSubview(labTitle)
        labTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20.w)
        }
        
        let btnClose = UIButton(image: UIImage(named: "icon_wallet_close"))
        btnClose.addTarget(self, action: #selector(onclickClose), for: .touchUpInside)
        self.view.addSubview(btnClose)
        btnClose.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(labTitle)
            make.size.equalTo(CGSize(width: 60.w, height: 30.w))
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(labTitle.snp.bottom).offset(20.w)
        }
    }
    
    lazy var dataArr : [Token] = {
        let arr = Account.currentAccount?.tokens ?? []
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
        tableview.register(IVWalletTokenCell.self, forCellReuseIdentifier: "IVWalletTokenCell")
        return tableview
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension IVWalletSelectTokenVC{
    @objc func onclickClose(){
        self.dismiss(animated: true)
    }
}

extension IVWalletSelectTokenVC: UITableViewDelegate,UITableViewDataSource{
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "IVWalletTokenCell", for: indexPath) as! IVWalletTokenCell
        cell.model = self.dataArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectBlock?(self.dataArr[indexPath.row])
        self.onclickClose()
    }
}
