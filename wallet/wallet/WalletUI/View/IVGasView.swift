//
//  IVGasView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/24.
//

import UIKit

enum IVGasType : String {
    case fast = "Fastest"
    case speed = "Speed"
    case slow = "Slow"
}

class IVGasView: UIView {
    let gwei = "1000000000"
    
    var selectBlock : ((Int)->())?
    
    private var chain : Chain!
    
    convenience init(chain : Chain) {
        self.init()
        self.chain = chain
        self.gas = gas
    }
    
    var gas : IVGasModel!{
        didSet{
            createUI()
        }
    }
    
    
    func createUI() {
        self.removeAllSubviews()
        let labTitle = UILabel.init(font: UIFont.TTTrialRegular(size: 14),textColor: UIColor.init(white: 1, alpha: 0.6),text: "Gas")
        self.addSubview(labTitle)
        labTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16.w)
        }
        
        if chain.chainId == 56{
            let gasView = self.createItem(type: .speed, gasPrice: gas.use_gasPrice)
            gasView.backgroundColor = color_7146FF
            self.addSubview(gasView)
            gasView.snp.makeConstraints { make in
                make.top.equalTo(labTitle.snp.bottom).offset(10.w)
                make.bottom.equalToSuperview().offset(-20.w)
                make.left.equalToSuperview().offset(16.w)
                make.width.equalTo(165.w)
            }
            return
        }
        
        let fastGasView = self.createItem(type: .fast, gasPrice: gas.getMinersPrice(0),tag: 100)
        self.addSubview(fastGasView)
        fastGasView.snp.makeConstraints { make in
            make.top.equalTo(labTitle.snp.bottom).offset(10.w)
            make.left.equalToSuperview().offset(16.w)
            make.width.equalTo(165.w)
        }
        
        let speedGasView = self.createItem(type: .speed, gasPrice: gas.getMinersPrice(1))
        speedGasView.backgroundColor = color_7146FF
        self.addSubview(speedGasView)
        speedGasView.snp.makeConstraints { make in
            make.centerY.equalTo(fastGasView)
            make.right.equalToSuperview().offset(-16.w)
            make.width.equalTo(165.w)
        }
        
        let slowGasView = self.createItem(type: .slow, gasPrice: gas.getMinersPrice(2),tag: 102)
        self.addSubview(slowGasView)
        slowGasView.snp.makeConstraints { make in
            make.top.equalTo(fastGasView.snp.bottom).offset(12.w)
            make.bottom.equalToSuperview().offset(-20.w)
            make.left.equalToSuperview().offset(16.w)
            make.width.equalTo(165.w)
        }
        
    }
    
    
    func createItem(type : IVGasType,gasPrice:String,tag : Int = 101) -> UIView{
        let gas = String(format:"%.1f",gasPrice.division(numberString: gwei).toDouble())  + " GWei"
        let view = UIView(UIColor(white: 1, alpha: 0.08))
        view.tag = tag
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickType(_:))))
        view.dealLayer(corner: 6.w)
        let labSeed = UILabel(font: UIFont.TTTrialBold(size: 14),textColor: UIColor.white,text: type.rawValue)
        view.addSubview(labSeed)
        labSeed.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20.w)
        }
        
        let labGasPrice = UILabel(font: UIFont.TTTrialRegular(size: 12),textColor: UIColor(white: 1, alpha: 0.6),text: gas)
        view.addSubview(labGasPrice)
        labGasPrice.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labSeed.snp.bottom).offset(10.w)
            make.bottom.equalToSuperview().offset(-20.w)
        }
        return view
    }
    
    @discardableResult
    func changeAction(_ action: @escaping (Int) -> Void) -> IVGasView {
        selectBlock = action
        return self
    }
}

extension IVGasView{
    @objc func clickType(_ tap : UITapGestureRecognizer){
        self.subviews.forEach { view in
            if view.tag >= 100{
                view.backgroundColor = UIColor(white: 1, alpha: 0.08)
            }
        }
        tap.view?.backgroundColor = color_7146FF
        selectBlock?((tap.view?.tag ?? 101) - 100)
    }
}
