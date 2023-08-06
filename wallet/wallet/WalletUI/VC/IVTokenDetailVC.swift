//
//  IVTokenDetailVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/24.
//

import UIKit

class IVTokenDetailVC: IVRefreshControl {
    var isLoadMore = false
    var token : Token?
    
    var dataArr : [IVTradeListModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.token?.symbol
        self.createUI()
        IVToast.loding()
        self.refressh()
    }
    
    func createUI(){
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalToSuperview().offset(navHeight);
        }
        self.view.backgroundColor = UIColor.white
        headerView.model = token
        self.setFooterView()
    }
    
    
    lazy var tableView: UITableView = {
        let view = UITableView (frame: .zero, style: .grouped)
        view.delegate = self
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        view.dataSource = self
        view.register(IVTokenDetailCell.self, forCellReuseIdentifier: "IVTokenDetailCell")
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.rowHeight = 60.w//UITableView.automaticDimension
//        view.estimatedRowHeight = 100
        view.tableHeaderView = headerView
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false;
        self.setRefreshView(view)
        return view
    }()
    
    lazy var headerView : IVDetailTokenHeadView = {
        let heaverView = IVDetailTokenHeadView(frame: CGRect(x: 0, y: 0, width: Screen_width, height: 230.w))
        return heaverView
    }()
}

extension IVTokenDetailVC{
    override func refressh() {
        self.endRefreshing()
    }
    
    func setFooterView() {
        self.tableView.tableFooterView = self.dataArr.count == 0 ? IVPlaceholder.show(.empty,frame: CGRect(x: 0, y: 0, width: Screen_width, height: Screen_height - navHeight - 380.w)) : nil
    }
    
}


extension IVTokenDetailVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.w
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(UIColor.clear)
        view.frame = CGRect.init(x: 0, y: 0, width: Screen_width, height: 50.w)
        let lab = UILabel.init(font: UIFont.TTTrialBold(size: 16), textColor: UIColor.white , text: LocalAll.localized)
        view.addSubview(lab)
        lab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16.w)
            make.centerY.equalToSuperview()
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IVTokenDetailCell", for: indexPath) as! IVTokenDetailCell
        let model = self.dataArr[indexPath.row]
        cell.model = model
        return cell
    }
}
