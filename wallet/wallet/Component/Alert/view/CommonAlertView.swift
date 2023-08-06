//
//  CommonAlertView.swift
//  ICE VPN
//
//  Created by HaydenYe on 2023/6/12.
//

import UIKit
import SnapKit

class CommonAlertView: UIView, AutoLocalizationProtocol {
    var imageName = "icon_success"
    var titleText = ""
    var confirmText = ""
    var cancelText = ""
    
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
        layer.masksToBounds = true
        layer.cornerRadius = 12.w
        
        // localized
        LocalizationTool.shared.addDelegate(self)
        setupLocalizationText()
    }
    
    func setupLocalizationText() {
        icon.image = UIImage(named: imageName)
        title.text = titleText.localized
        confirmButton.setTitle(confirmText.localized, for: .normal)
        cancelButton.setTitle(cancelText.localized, for: .normal)
    }
    
    func setup() {
        addSubview(icon)
        addSubview(title)
        addSubview(confirmButton)
        addSubview(cancelButton)
        
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24.w)
            make.width.equalTo(114.w)
            make.height.equalTo(99.w)
        }
        
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30.w)
            make.trailing.equalToSuperview().offset(-30.w)
            make.top.equalTo(icon.snp.bottom).offset(20.w)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(title)
            make.top.equalTo(title.snp.bottom).offset(37.w)
            make.height.equalTo(51.w)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(title)
            make.top.equalTo(confirmButton.snp.bottom).offset(16.w)
            make.bottom.equalToSuperview().offset(-20.w)
        }
    }
    
    lazy var icon = UIImageView(image: UIImage(named: imageName))
    lazy var title = {
        let label = UILabel(font: .TTTrialBold(size: 16), textColor: .black)
        label.textAlignment = .center
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    lazy var confirmButton = {
        let btn = UIButton(font: UIFont.TTTrialBold(size: 17), color: .white, backgroundImage: UIImage(named: "common_button_image"))
        btn.isHidden  = true
        return btn
    }()
    lazy var cancelButton = {
        let btn = UIButton(font: UIFont.TTTrialRegular(size: 14), color: .black)
        btn.isHidden  = true
        return btn
    }()
}
