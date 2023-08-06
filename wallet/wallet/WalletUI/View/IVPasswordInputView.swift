//
//  IVPasswordInputView.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/30.
//

import UIKit

class IVPasswordConfig{
    //默认的密码长度
    var num = 6
    var font = UIFont.Bold(size: 36)
    var width = 50.w
    var height = 50.w
    var left = 8.w
    var textColor = UIColor.white
    var square = 10.w
    var borderColor : UIColor = UIColor.clear
    convenience init(num : Int = 6,font:UIFont = UIFont.Bold(size: 36),color:UIColor = UIColor.white,width : CGFloat = 50.w,height : CGFloat = 50.w,left: CGFloat = 8.w,square : CGFloat = 10.w,borderColor : UIColor = UIColor.clear) {
        self.init()
        self.num = num
        self.font = font
        self.textColor = color
        self.width = width
        self.height = height
        self.left = left
        self.square = square
        self.borderColor = borderColor
    }
}


class IVPasswordInputView: UIView {
    var labArr : [UILabel] = []
    var passwords : [String]  = []
    var config : IVPasswordConfig = IVPasswordConfig()
    var inputDoneBlock : (()->())?
    
    convenience init(config : IVPasswordConfig) {
        self.init(frame:CGRect.zero)
        self.config = config
        self.createUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        let height = self.config.height
        let width = self.config.width
        let square = self.config.square
        let left = self.config.left
        for i in 0..<self.config.num{
            let lab = UILabel.init(font: self.config.font, textColor: self.config.textColor)
            lab.backgroundColor = UIColor.init(white: 1, alpha: 0.08)
            lab.textAlignment = .center
            lab.dealBorderLayer(corner: 10.w, bordercolor: self.config.borderColor, borderwidth: 1)
            lab.frame = CGRect.init(x: left + CGFloat(i)*(width + square), y: 0, width: width, height: height)
            self.addSubview(lab)
            self.labArr.append(lab)
        }
    }
    
    private func reset() {
        for (index,lab) in self.labArr.enumerated(){
            if index < self.passwords.count{
                if (index == self.passwords.count - 1 && index != 5){
                    lab.text = self.passwords[index]
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        lab.text = "*"
                    })
                }else{
                    lab.text = "*"
                }
            }else{
                lab.text = "";
            }
        }
    }
    
    func clean(){
        self.passwords.removeAll()
        self.reset()
    }
    
}


extension IVPasswordInputView : UIKeyInput{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isFirstResponder == false {
            super.becomeFirstResponder()
        }
    }
    
    var hasText: Bool {
        return self.passwords.count > 0
    }
    
    func insertText(_ text: String) {
        if self.passwords.count < self.config.num{
            self.passwords.append(text)
            self.reset()
            //输入完成
            if self.passwords.count == self.config.num{
                self.inputDoneBlock?()
            }
        }
    }
    
    func deleteBackward() {
        if self.passwords.count > 0{
            self.passwords.removeLast()
            self.reset()
        }
    }
    
    var keyboardType: UIKeyboardType{
        get{
            return .numberPad
        }
        set{
            
        }
    }
    
    override var canResignFirstResponder: Bool{
        return true
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
}
