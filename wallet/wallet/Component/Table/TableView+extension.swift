//
//  TableView+extension.swift
//  ICE VPN
//
//  Created by HaydenYe on 2023/6/20.
//

import UIKit

extension UITableView {
    convenience init(style: UITableView.Style) {
        self.init()
        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0
        }
        showsVerticalScrollIndicator = false
        contentInsetAdjustmentBehavior = .never
        backgroundColor = UIColor.clear
        separatorStyle = .none
        tableFooterView = UIView(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 15.w))
        rowHeight = UITableView.automaticDimension
    }
}
