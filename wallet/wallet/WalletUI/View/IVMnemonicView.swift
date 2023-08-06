//
//  IVMnemonicView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/12.
//

import UIKit

class IVMnemonicView: UIView {
    var clickBlock : ((Int,String)->())?
    var mnemonic : [String]?
    var selectMnemonic : [String] = []
    convenience init(mnemonic : [String],isGradine : Bool = true) {
        self.init()
        if (isGradine){
            self.addLeftTopToRightBottomGradient(colors: [color_AD01BA.cgColor,color_3A00F9.cgColor], size: CGSize.init(width: 343.w, height: 267.w), cornerRadius: 8.w)
        }
        self.mnemonic = mnemonic
        self.setWordsView(words: mnemonic)
    }

    private func setWordsView(words:[String]) {
        let line: CGFloat = 3
        var x: CGFloat = 9.w
        var y: CGFloat = 12.w
        let w: CGFloat = (Screen_width - 50.w - 12.w) / 3.0
        let h: CGFloat = 50.w
        let spacex: CGFloat = 6.w
        let spacey: CGFloat = 13.w
        for index  in 0..<12 {
            let column: CGFloat = CGFloat(index % Int(line))
            let row : CGFloat = CGFloat(index / Int(line))
            x = 9.w + column * (w + spacex)
            y = 12.w + row * (h + spacey)
            let view = UIView.init(UIColor.init(white: 1, alpha: 0.08))
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickItem(_:))))
            view.dealLayer(corner: 6.w)
            view.tag = index
            view.frame = CGRect.init(x: x, y: y, width: w, height: h)
            self.addSubview(view)
            let value = words.count > index ? words[index] : ""
            if (selectMnemonic.count > 0 && selectMnemonic.contains(value)){
                view.addLeftTopToRightBottomGradient(colors: [color_AD01BA.cgColor,color_3A00F9.cgColor], size: CGSize.init(width: w, height: h), cornerRadius: 6.w)
            }
            let label = UILabel.init(font: UIFont.TTTrialBold(size: 14), textColor: UIColor.white, text: value)
            view.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }
    }
    
    func updateMnemonic(mnemonic : [String]) {
        self.mnemonic = mnemonic
        self.removeAllSubviews()
        setWordsView(words: mnemonic)
    }
    
    func updateSelectMnemonic(mnemonic : [String]) {
        self.selectMnemonic = mnemonic
        self.removeAllSubviews()
        setWordsView(words: self.mnemonic ?? [])
    }
}

extension IVMnemonicView{
    @objc func clickItem(_ tap : UITapGestureRecognizer){
        guard let index = tap.view?.tag , index < (self.mnemonic?.count ?? 0) else{
            return
        }
        self.clickBlock?(index,self.mnemonic![index])
    }
}
