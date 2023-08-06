//
//  IVAccountVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/13.
//

import UIKit

class IVAccountVC: UIViewController {
    
    var model : Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        getData()
    }
    
    func createUI(){
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func getData(){
        self.model = Account.currentAccount
    }
    
    func updateChain(_ chain : Chain) {
        self.model?.changeChain(chain)
        Account.currentAccount = self.model
        self.tableView.reloadData()
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
        tableview.register(IVAccountCell.self, forCellReuseIdentifier: "IVAccountCell")
        tableview.tableHeaderView = self.headView
        tableview.rowHeight = UITableView.automaticDimension
        return tableview
    }()
    
    lazy var headView : IVAccountHeadView = {
        let view = IVAccountHeadView(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 50.w*CGFloat(cards.count)), cards: cards)
        return view
    }()
    
    lazy var cards : [IVAccountCardModel] = {
        let cards = [IVAccountCardModel.init(name: "Weekly card", num: 0),
                     IVAccountCardModel.init(name: "Monthly card", num: 0),
                     IVAccountCardModel.init(name: "Quarter card", num: 0),
                     IVAccountCardModel.init(name: "Annual card", num: 0)]
        return cards
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension IVAccountVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.w
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Screen_width, height: 50.w))
        let lab = UILabel(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.white,text: "Details")
        view.addSubview(lab)
        lab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16.w)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IVAccountCell", for: indexPath) as! IVAccountCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
