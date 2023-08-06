//
//  Date+extension.swift
//  ICE VPN
//
//  Created by HaydenYe on 2023/6/13.
//

import Foundation

extension Date{
    //MARK:获取当前时间戳
    func getTimeStampLong() -> String{
        let timeInterval = Int(self.timeIntervalSince1970)*1000
        return "\(timeInterval)"
    }
    
    func getTimeStamp() -> String{
        let timeInterval = Int(self.timeIntervalSince1970)
        return "\(timeInterval)"
    }
    
    func systemNowDate() -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyyMMddHHmmssSSS"
        return format.string(from:self)
    }
    
    func getDateFormat() -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日"
        return format.string(from: self)
    }
    
    func getDateYYYYMMdd() -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: self)
    }
    
    
    
    func getDateMMdd() -> String{
        let format = DateFormatter()
        format.dateFormat = "MM/dd"
        return format.string(from: self)
    }
    
    func getDateDD() -> String{
        let format = DateFormatter()
        format.dateFormat = "dd"
        return format.string(from: self)
    }
    
    func getDateMM() -> String{
        let format = DateFormatter()
        format.dateFormat = "MM"
        return format.string(from: self)
    }
    
    func getDate(_ strFormat : String) -> String{
        let format = DateFormatter()
        format.dateFormat = strFormat
        return format.string(from: self)
    }
    
    func getDateYY() -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        return format.string(from: self)
    }
     
    func getDateMMdd3() -> String{
        let format = DateFormatter()
        format.dateFormat = "MM月dd日"
        return format.string(from: self)
    }
    
    
    func getDateDay() -> String{
        let format = DateFormatter()
        format.dateFormat = "MM-dd"
        return format.string(from: self)
    }
    
    func getDateHHmm() -> String{
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        return format.string(from: self)
    }
    
    func getDateMMDDHHmm() -> String{
        let format = DateFormatter()
        format.dateFormat = "MM-dd HH:mm"
        return format.string(from: self)
    }
}
