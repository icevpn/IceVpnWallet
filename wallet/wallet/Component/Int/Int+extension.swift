//
//  Int+extension.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/1.
//

import UIKit

extension Int {
    var w : CGFloat{
        get{
            return (Screen_width/375.0)*CGFloat(self)
        }
    }
    
    var h : CGFloat{
        get{
            return (Screen_height/812.0)*CGFloat(self)
        }
    }
}

extension Int {
    func getUnitWithDecimails() -> String {
        var  decimalStr = "1"
        for _ in 0..<self  {
            decimalStr += "0"
        }
        return decimalStr
    }
}

extension Int {
    func transToHourMinSec() -> String
    {
        let allTime: Int = self
        var hours = 0
        var minutes = 0
        var seconds = 0
        var hoursText = ""
        var minutesText = ""
        var secondsText = ""
        
        hours = allTime / 3600
        hoursText = hours > 9 ? "\(hours)" : "0\(hours)"
        
        minutes = allTime % 3600 / 60
        minutesText = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        seconds = allTime % 3600 % 60
        secondsText = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return "\(hoursText):\(minutesText):\(secondsText)"
    }
    
    func transToMin() -> String
    {
        let allTime: Int = self
        var minutes = 0
        var minutesText = ""
        
        minutes = allTime / 60
        minutesText = minutes < 1 ?
        minutes == 0 ? "\(minutes)" : "<1"
        : "\(minutes)"
        
        return minutesText
    }
    
    func transToDay() -> String
    {
        let allTime: Int = self
        var day = 0
        var dayText = ""
        
        day = allTime / (3600 * 24)
        dayText = day < 1 ? "<1" : "\(day)"
        
        return dayText
    }
}
