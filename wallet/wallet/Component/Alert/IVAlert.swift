//
//  IVAlert.swift
//  ICE VPN
//
//  Created by HaydenYe on 2023/6/12.
//

import UIKit
import SnapKit

enum IVAlert {
    case tip
    case success
    
    static func alert(_ type: IVAlert = tip) -> IVAlertController {
        let alert = IVAlertController()
        alert.type = type
        return alert
    }
}

extension IVAlertController {
    @discardableResult
    func title(_ title: String) -> IVAlertController {
        guard let alert = self.alert as? CommonAlertView else { return self }
        alert.titleText = title
        alert.title.isHidden = false
        return self
    }
    
    @discardableResult
    func confirm(_ buttonText: String) -> IVAlertController {
        guard let alert = self.alert as? CommonAlertView else { return self }
        alert.confirmText = buttonText
        alert.confirmButton.isHidden = false
        return self
    }
    
    @discardableResult
    func cancel(_ buttonText: String) -> IVAlertController {
        guard let alert = self.alert as? CommonAlertView else { return self }
        alert.cancelText = buttonText
        alert.cancelButton.isHidden = false
        return self
    }
    
    @discardableResult
    func confirmAction(_ action: @escaping () -> Void) -> IVAlertController {
        guard self.alert is CommonAlertView else { return self }
        confirmAction = action
        return self
    }
    
    @discardableResult
    func cancelAction(_ action: @escaping () -> Void) -> IVAlertController {
        guard self.alert is CommonAlertView else { return self }
        cancelAction = action
        return self
    }
    
    @discardableResult
    func customView(_ view: UIView) -> IVAlertController {
        alert = view
        return self
    }
    
    @discardableResult
    func popup() -> IVAlertController {
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        UIUtil.visibleVC()?.present(self, animated: true)
        return self
    }
}

class IVAlertController: UIViewController {
    var type = IVAlert.tip
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setup()
    }
    
    func setup() {
        view.addSubview(alert)
        
        alert.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(24.w)
            make.trailing.equalToSuperview().offset(-24.w)
        }
    }
    
    private lazy var alert: UIView = {
        let view = CommonAlertView()
        switch type {
        case .tip:
            view.imageName = "icon_tip"
        case .success:
            view.imageName = "icon_success"
        }

        view.confirmButton.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        
        return view
    }()
    
    private var confirmAction: (() -> Void)? = nil
    private var cancelAction: (() -> Void)? = nil
}

extension IVAlertController {
    @objc func confirmButtonAction() {
        dismiss(animated: false, completion: confirmAction)
    }
    
    @objc func cancelButtonAction() {
        dismiss(animated: false, completion: cancelAction)
    }
}


