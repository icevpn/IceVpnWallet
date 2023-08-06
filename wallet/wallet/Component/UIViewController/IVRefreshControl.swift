//
//  IVRefreshControl.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/24.
//

import UIKit

class IVRefreshControl: IVBaseViewController {
    var page = 1
    private var contentScrollView : UIScrollView?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    func setRefreshView(_ scrollView : UIScrollView){
        self.contentScrollView = scrollView
        let refreshControl = UIRefreshControl();
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(refressh), for: .valueChanged)
        self.contentScrollView?.refreshControl = refreshControl;
    }

}

extension IVRefreshControl{
    func beginRefreshing(){
        if self.contentScrollView?.refreshControl?.isRefreshing == false{
            self.contentScrollView?.refreshControl?.beginRefreshing()
            self.contentScrollView?.refreshControl?.sendActions(for: .valueChanged)
        }
    }
    
    func endRefreshing(){
        self.contentScrollView?.refreshControl?.endRefreshing()
    }
    
    
    @objc func refressh(){
        
    }
}
