//
//  IVInputAlert.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/19.
//

import UIKit

class IVInputAlert: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alert.textField.becomeFirstResponder()
    }
    
    func setup() {
        view.addSubview(alert)
        alert.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50.w)
            make.leading.equalToSuperview().offset(24.w)
            make.trailing.equalToSuperview().offset(-24.w)
        }
    }
    
    private lazy var alert: IVInputAlertView = {
        let view = IVInputAlertView()
        view.confirmAction = {[weak self] value in
            self?.confirmResult(value)
        }
        view.cancelAction = {[weak self] in
            self?.cancel()
        }
        return view
    }()
    
    private var confirmAction: ((String) -> Void)? = nil
    private var cancelAction: (() -> Void)? = nil
}

extension IVInputAlert{
 
    func confirmResult(_ value : String){
        confirmAction?(value)
        dismiss(animated: true)
    }
    
    func cancel() {
        dismiss(animated: true,completion: cancelAction)
    }
}

extension IVInputAlert {
    @discardableResult
    func title(_ title: String) -> IVInputAlert {
        alert.titleText = title
        alert.title.isHidden = false
        return self
    }
    
    @discardableResult
    func confirm(_ buttonText: String) -> IVInputAlert {
        alert.confirmText = buttonText
        return self
    }
    
    @discardableResult
    func cancel(_ buttonText: String) -> IVInputAlert {
        alert.cancelText = buttonText
        return self
    }
    
    @discardableResult
    func confirmAction(_ action: @escaping (String) -> Void) -> IVInputAlert {
        confirmAction = action
        return self
    }
    
    @discardableResult
    func cancelAction(_ action: @escaping () -> Void) -> IVInputAlert {
        cancelAction = action
        return self
    }
    
    @discardableResult
    func popup() -> IVInputAlert {
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        UIUtil.visibleVC()?.present(self, animated: false)
        return self
    }
}
