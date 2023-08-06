//
//  IVScanView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/13.
//

import UIKit
let XRetangleLeft = 75.w

class IVScanView: UIView {
    
    let viewHeight = Screen_height
    
    var scanAnimation = IVScanAnimationView()
    
    var activityView: UIActivityIndicatorView?
    
    var isAnimationing = false
        

    deinit {
        scanAnimation.stopStepAnimating()
    }
    
    
    // 开始扫描动画
    func startScanAnimation() {
        guard !isAnimationing else {
            return
        }
        isAnimationing = true
        let cropRect = getScanRectForAnimation()
        scanAnimation.startAnimatingWithRect(animationRect: cropRect, parentView: self, image: UIImage(named: "icon_scan_line"))
    }
    
    // 开始扫描动画
    func stopScanAnimation() {
        isAnimationing = false
        scanAnimation.stopStepAnimating()
    }
    
    
    override func draw(_ rect: CGRect) {
        drawScanRect()
    }
    
    //MARK: ----- 绘制扫码效果-----
    func drawScanRect() {
        let sizeRetangle = CGSize(width: Screen_width - XRetangleLeft * 2.0, height: Screen_width - XRetangleLeft * 2.0)
        // 扫码区域Y轴最小坐标
        let YMinRetangle = Screen_height / 2.0 - sizeRetangle.height / 2.0 - 64.h
        let YMaxRetangle = YMinRetangle + sizeRetangle.height
        let XRetangleRight = Screen_width - XRetangleLeft
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setFillColor(UIColor.init(white: 0, alpha: 0.2).cgColor)
        //上
        var rect = CGRect(x: 0, y: 0, width: Screen_width, height: YMinRetangle)
        context.fill(rect)
        //左
        rect = CGRect(x: 0, y: YMinRetangle, width: XRetangleLeft, height: sizeRetangle.height)
        context.fill(rect)
        //右
        rect = CGRect(x: XRetangleRight, y: YMinRetangle, width: XRetangleLeft, height: sizeRetangle.height)
        context.fill(rect)
        //下
        rect = CGRect(x: 0, y: YMaxRetangle, width: Screen_width, height: Screen_height - YMaxRetangle)
        context.fill(rect)
        
        context.strokePath()
        
//        context.setStrokeColor(UIColor.white.cgColor)
//        context.setLineWidth(1)
//        context.addRect(CGRect(x: XRetangleLeft, y: YMinRetangle, width: sizeRetangle.width, height: sizeRetangle.height))
//        context.strokePath()
        
        _ = CGRect(x: XRetangleLeft, y: YMinRetangle, width: sizeRetangle.width, height: sizeRetangle.height)
        
        let wAngle = 20.w
        let hAngle = 20.w
        // 4个角的 线的宽度
        let linewidthAngle : CGFloat = 2
        // 画扫码矩形以及周边半透明黑色坐标参数
        var diffAngle = linewidthAngle / 3
        diffAngle = linewidthAngle / 2 // 框外面4个角，与框有缝隙
        diffAngle = linewidthAngle / 2 // 框4个角 在线上加4个角效果
        diffAngle = 0 // 与矩形框重合
        diffAngle = -1
        
        context.setStrokeColor(UIColor.white.cgColor)
        context.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        // Draw them with a 2.0 stroke width so they are a bit more visible.
        context.setLineWidth(linewidthAngle)
    
        let leftX = XRetangleLeft - diffAngle
        let topY = YMinRetangle - diffAngle
        let rightX = XRetangleRight + diffAngle
        let bottomY = YMaxRetangle + diffAngle

        // 左上角水平线
        context.move(to: CGPoint(x: leftX - linewidthAngle / 2, y: topY))
        context.addLine(to: CGPoint(x: leftX + wAngle, y: topY))
        
        // 左上角垂直线
        context.move(to: CGPoint(x: leftX, y: topY - linewidthAngle / 2))
        context.addLine(to: CGPoint(x: leftX, y: topY + hAngle))
        
        // 左下角水平线
        context.move(to: CGPoint(x: leftX - linewidthAngle / 2, y: bottomY))
        context.addLine(to: CGPoint(x: leftX + wAngle, y: bottomY))
        
        // 左下角垂直线
        context.move(to: CGPoint(x: leftX, y: bottomY + linewidthAngle / 2))
        context.addLine(to: CGPoint(x: leftX, y: bottomY - hAngle))

        // 右上角水平线
        context.move(to: CGPoint(x: rightX + linewidthAngle / 2, y: topY))
        context.addLine(to: CGPoint(x: rightX - wAngle, y: topY))
        
        // 右上角垂直线
        context.move(to: CGPoint(x: rightX, y: topY - linewidthAngle / 2))
        context.addLine(to: CGPoint(x: rightX, y: topY + hAngle))

        // 右下角水平线
        context.move(to: CGPoint(x: rightX + linewidthAngle / 2, y: bottomY))
        context.addLine(to: CGPoint(x: rightX - wAngle, y: bottomY))

        // 右下角垂直线
        context.move(to: CGPoint(x: rightX, y: bottomY + linewidthAngle / 2))
        context.addLine(to: CGPoint(x: rightX, y: bottomY - hAngle))
        
        context.strokePath()
    }
    
    
    func getRetangeSize() -> CGSize {
        var sizeRetangle = CGSize(width: Screen_width - XRetangleLeft * 2, height: Screen_width - XRetangleLeft * 2)
        sizeRetangle = CGSize(width: sizeRetangle.width, height: sizeRetangle.width)
        return sizeRetangle
    }
    
    func deviceStartReadying() {
        let XRetangleLeft = 75.w
        let sizeRetangle = getRetangeSize()
        let YMinRetangle = frame.size.height / 2.0 - sizeRetangle.height / 2.0
        if activityView == nil {
            activityView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            activityView?.center = CGPoint(x: XRetangleLeft + sizeRetangle.width / 2 - 50, y: YMinRetangle + sizeRetangle.height / 2)
            activityView?.style = UIActivityIndicatorView.Style.large
            addSubview(activityView!)
        }
        activityView?.startAnimating()
    }
    
    func deviceStopReadying() {
        if activityView != nil {
            activityView?.stopAnimating()
            activityView?.removeFromSuperview()
            activityView = nil
        }
    }

}

extension IVScanView {
    /// 获取扫描动画的Rect
    func getScanRectForAnimation() -> CGRect {
        let sizeRetangle = CGSize(width: Screen_width - XRetangleLeft * 2,
                                  height: Screen_width - XRetangleLeft * 2)
        // 扫码区域Y轴最小坐标
        let YMinRetangle = Screen_height / 2.0 - sizeRetangle.height / 2.0 - 64.h
        // 扫码区域坐标
        let cropRect = CGRect(x: XRetangleLeft, y: YMinRetangle, width: sizeRetangle.width, height: sizeRetangle.height)
        return cropRect
    }
    
}
