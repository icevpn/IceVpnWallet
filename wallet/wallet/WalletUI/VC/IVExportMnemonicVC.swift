//
//  IVExportMnemonicVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/19.
//

import UIKit

class IVExportMnemonicVC: IVBaseViewController {
    var walletName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalExportMnemonic.localized
        createUI()
    }
    
    func createUI(){
        let labTips = UILabel.init(font: UIFont.TTTrialRegular(size: 13),textColor: UIColor.white,text: LocalBackupMnemonicTips1.localized)
        labTips.numberOfLines = 0
        self.view.addSubview(labTips)
        labTips.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.top.equalToSuperview().offset(navHeight + 28.w)
        }
        
        self.view.addSubview(mnemonicView)
        mnemonicView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labTips.snp.bottom).offset(20.w)
            make.size.equalTo(CGSize.init(width: 343.w, height: 267.w))
        }
        
        let labNoteTitle = UILabel.init(font: UIFont.TTTrialBold(size: 12),textColor: UIColor.init(white: 1, alpha: 0.6),text: "Notice:")
        self.view.addSubview(labNoteTitle)
        labNoteTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.top.equalTo(mnemonicView.snp.bottom).offset(35.w)
        }
        
        let labNote = UILabel.init(font: UIFont.TTTrialRegular(size: 12),textColor: UIColor.init(white: 1, alpha: 0.6),text: LocalBackupMnemonicTips2.localized)
        labNote.numberOfLines = 0
        self.view.addSubview(labNote)
        labNote.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.w)
            make.right.equalToSuperview().offset(-16.w)
            make.top.equalTo(labNoteTitle.snp.bottom).offset(10.w)
        }
        
    }
    
    lazy var mnemonics : [String] = {
        let mnemonics = Account.currentAccount?.mnemonic.split(separator: " ").map{String($0)}
        return mnemonics ?? []
    }()
    
    lazy var mnemonicView : IVMnemonicView = {
        let view = IVMnemonicView(mnemonic: self.mnemonics)
        return view
    }()
}


