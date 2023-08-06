//
//  IVScanWrapper.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/13.
//

import UIKit
import AVFoundation

class IVScanWrapper: NSObject,AVCaptureMetadataOutputObjectsDelegate {
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    // 扫码结果返回block
    var successBlock: ([String]) -> Void

    init(videoPreView: UIView,
         success: @escaping (([String]) -> Void)) {
        successBlock = success
        super.init()
        
        // 设置默认的设备为后置摄像头
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            session.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
            previewLayer!.frame = videoPreView.bounds
            videoPreView.layer.insertSublayer(previewLayer!, at: 0)
            
        } catch {
            // 处理异常
            print(error)
        }
    }

    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection) {
        captureOutput(output, didOutputMetadataObjects: metadataObjects, from: connection)
    }
    
    func start() {
        if !session.isRunning {
            DispatchQueue.global().async {
                self.session.startRunning()
            }
        }
    }
    
    func stop() {
        if session.isRunning {
            session.stopRunning()
        }
    }
    
    open func captureOutput(_ captureOutput: AVCaptureOutput,
                            didOutputMetadataObjects metadataObjects: [Any],
                            from connection: AVCaptureConnection!) {
        
        var arrayResult : [String] = []
        // 识别扫码类型
        for current in metadataObjects {
            guard let code = (current as? AVMetadataMachineReadableCodeObject)?.stringValue else {
                continue
            }
            #if !targetEnvironment(simulator)
            arrayResult.append(code)
            #endif
        }
        stop()
        successBlock(arrayResult)
    }
}

extension IVScanWrapper{
    /**
     识别二维码码图像
     - parameter image: 二维码图像
     - returns: 返回识别结果
     */
    public static func recognizeQRImage(image: UIImage) -> [String] {
        guard let cgImage = image.cgImage else {
            return []
        }
        let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])!
        let img = CIImage(cgImage: cgImage)
        let features = detector.features(in: img, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        return features.filter {
            $0.isKind(of: CIQRCodeFeature.self)
        }.map {
            $0 as! CIQRCodeFeature
        }.map {
            $0.messageString ?? ""
        }
    }
}

