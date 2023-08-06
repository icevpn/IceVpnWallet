//
//  IVInputAlertView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/19.
//

import UIKit

class IVInputAlertView: UIView {
    var titleText = ""
    var confirmText = LocalConfirm.localized
    var cancelText = LocalCancle.localized
    
    var confirmAction: ((String) -> Void)?
    var cancelAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        dealLayer(corner: 12.w)
        setupLocalizationText()
    }
    
    func setupLocalizationText() {
        title.text = titleText
        confirmButton.setTitle(confirmText, for: .normal)
        cancelButton.setTitle(cancelText, for: .normal)
    }
    
    func setup() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30.w)
            make.trailing.equalToSuperview().offset(-30.w)
            make.top.equalToSuperview().offset(20.w)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30.w)
            make.trailing.equalToSuperview().offset(-30.w)
            make.top.equalTo(title.snp.bottom).offset(25.w)
            make.height.equalTo(45.w)
        }
        
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(textField.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(51.w)
        }
        
        addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.centerY.equalTo(cancelButton)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(51.w)
        }
        
        
    }
    
    lazy var title = {
        let label = UILabel(font: UIFont.Medium(size: 17), textColor: .black)
        label.textAlignment = .center
        return label
    }()
    
    lazy var textField : UITextField = {
        let text = UITextField("Wallet name",font: UIFont.Regular(size: 14),textColor: UIColor.black)
        text.delegate = self
        text.leftWidth(14.w)
        text.dealBorderLayer(corner: 8.w, bordercolor: UIColor.black, borderwidth: 1)
        return text
    }()
    
    lazy var confirmButton = {
        let btn = UIButton(title: confirmText,font: UIFont.Medium(size: 17), color: color_7146FF)
        btn.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var cancelButton = {
        let btn = UIButton(title:cancelText,font: UIFont.Medium(size: 14), color: color_979797)
        btn.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return btn
    }()
}

extension IVInputAlertView{
    @objc func confirmButtonAction() {
        if (textField.text?.removeSpace() == ""){
            return
        }
        confirmAction?(textField.text!)
    }
    
    @objc func cancelButtonAction() {
        cancelAction?()
    }
}

extension IVInputAlertView : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        confirmButtonAction()
        return true
    }
}

