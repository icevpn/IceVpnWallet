//
//  IVTransferSelectTokenView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/9.
//

import UIKit

class IVTransferSelectTokenView: UIView {
    var selectBlock : ((Token)->())?
    var tokens : [Token]!
    convenience init(_ tokens : [Token]) {
        self.init()
        self.tokens = tokens
        self.backgroundColor = color_241E48
        self.createUI()
    }

    func createUI() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(IVWalletTokenCell.self, forCellReuseIdentifier: "IVWalletTokenCell")
        return tableview
    }()
}

extension IVTransferSelectTokenView: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tokens.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.w
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IVWalletTokenCell", for: indexPath) as! IVWalletTokenCell
        cell.model = self.tokens[indexPath.row]
        cell.bgView.backgroundColor = UIColor.clear
        
        cell.bgView.snp.updateConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectBlock?(self.tokens[indexPath.row])
    }
}
