//
//  IVScanVC.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/13.
//

import UIKit
import AVFoundation
import Photos

protocol IVScanDelegate{
    func scanResult(result : String?)
}

class IVScanVC: IVBaseViewController {
    
    var delegate : IVScanDelegate?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Scaning"
//        self.addRightItem(UIImage(named: "icon_scan_pic"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.backImage.isHidden = true
        perform(#selector(startScan), with: nil, afterDelay: 0.3)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        qrScanView.stopScanAnimation()
        scanObj.stop()
    }
    
    
    lazy var scanObj: IVScanWrapper = {
        let scanObj = IVScanWrapper(videoPreView: view,
                                 success: { [weak self] (arrayResult) -> Void in
                                     guard let strongSelf = self else {
                                         return
                                     }
            
                                     strongSelf.qrScanView.stopScanAnimation()
                                     strongSelf.handleCodeResult(arrayResult: arrayResult)
        })
        return scanObj
    }()
    
    lazy var qrScanView: IVScanView = {
        let qrScanView = IVScanView()
        qrScanView.backgroundColor = UIColor.clear
        view.addSubview(qrScanView)
        qrScanView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        qrScanView.deviceStartReadying()
        return qrScanView
    }()
    
}

extension IVScanVC{
    override func onRightAction() {
        self.authorizePhotoWith { [weak self] _ in
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self?.present(picker, animated: true, completion: nil)
        }
    }
    
    
    @objc open func startScan() {
        // 结束相机等待提示
        qrScanView.deviceStopReadying()
        // 开始扫描动画
        qrScanView.startScanAnimation()
        // 相机运行
        scanObj.start()
    }

    func handleCodeResult(arrayResult: [String]) {
        delegate?.scanResult(result: arrayResult.first)
        popPage()
    }
    
    func authorizePhotoWith(comletion: @escaping (Bool) -> Void) {
        let granted = PHPhotoLibrary.authorizationStatus()
        switch granted {
        case PHAuthorizationStatus.authorized:
            comletion(true)
        case PHAuthorizationStatus.denied, PHAuthorizationStatus.restricted:
            comletion(false)
        case PHAuthorizationStatus.notDetermined:
            PHPhotoLibrary.requestAuthorization({ status in
                DispatchQueue.main.async {
                    comletion(status == PHAuthorizationStatus.authorized)
                }
            })
        case .limited:
            comletion(true)
        @unknown default:
            comletion(false)
        }
    }
}

extension IVScanVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        guard let image = editedImage ?? originalImage else {
            
            return
        }
        let arrayResult = IVScanWrapper.recognizeQRImage(image: image)
        if !arrayResult.isEmpty {
            handleCodeResult(arrayResult: arrayResult)
        }
    }
    
}
