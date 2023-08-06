//
//  IVBaseViewController.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/5.
//

import UIKit

class IVBaseViewController: UIViewController {
    
    
    
    let backImage = UIImageView(image: UIImage(named: "LaunchImage"))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBack()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: "icon_navigation_back", target: self, action: #selector(self.popPage))
    }
    
    func addBack()  {
        self.view.addSubview(backImage)
        backImage.snp.makeConstraints({ make in
            make.edges.equalTo(self.view)
        })
    }
    
    @objc func popPage() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func popToRoot() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}

