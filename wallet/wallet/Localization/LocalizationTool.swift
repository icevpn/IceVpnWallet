//
//  LocalizationTool.swift
//  SiRu
//
//  Created by siru-mac8 on 2021/5/24.
//  Copyright © 2021 siru-mac5. All rights reserved.
//

import Foundation

enum Language : Int {
    case English = 0
    case Chinese
    case Korean
    case Japanese
    ///中文繁体
    case HongKong
    //俄语
    case Russian
//    case French
    //越南语
//    case Vietnamese
}

class LocalizationTool {
    static let shared = LocalizationTool()
    var bundle: Bundle?
    var currentLanguage: Language = .English
    
    private let defaults = UserDefaults.standard
    private var delegates = NSPointerArray.weakObjects()
    
    func addDelegate(_ delegate: AnyObject?) {
        guard let delegate = delegate else { return }
        delegates.addPointer(Unmanaged.passUnretained(delegate).toOpaque())
    }
    
    func valueWithKey(key: String) -> String {
        let bundle = LocalizationTool.shared.bundle
        if let bundle = bundle {
            return NSLocalizedString(key, tableName: "Localizable", bundle: bundle, value: "", comment: "")
        } else {
            return NSLocalizedString(key, comment: "")
        }
    }
    
    func setLanguage(language: Language) {
        if currentLanguage == language {
            return
        }
        defaults.set(String(language.rawValue), forKey: "language")
        currentLanguage = getLanguage()
        
        delegates.compact()
        delegates.allObjects.forEach { anyobj in
            if let delegate = anyobj as? AutoLocalizationProtocol {
                delegate.setupLocalizationText()
            }
        }
    }
    
    func checkLanguage() {
        currentLanguage = getLanguage()
    }
    
    private func getLanguage() -> Language {
        var type = Language.English
        if let language = defaults.value(forKey: "language") as? String {
            type = Language.init(rawValue: Int(language) ?? 1) ?? .English
        }else{
            type = getSystemLanguage()
        }
        if let path = Bundle.main.path(forResource:self.getLanguageSysName(type) , ofType: "lproj") {
            bundle = Bundle(path: path)
        }
        return type
    }
    
    func getLanguageSysName(_ type : Language) -> String {
        switch type {
        case .Chinese:
            return "zh-Hans"
        case .HongKong:
            return "zh-HK"
        case .English:
            return "en"
//        case .French:
//            return "fr"
        case .Russian :
            return "ru"
        case .Japanese:
            return "ja"
        case .Korean:
            return "ko"
//        case .Vietnamese:
//            return "vi"
        }
    }
    
    //提交到后端的类型
    func getHeaderLanguage() -> String {
        var language = self.getLanguageSysName(self.currentLanguage)
        if language == "zh-Hans" {
            language = "zh-Hans"
        }
        if language == "zh-HK" {
            language = "zh-Hant"
        }
        return language
    }
    
    func getSystemLanguage() -> Language {
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        let str = String(describing: preferredLang)
        switch str {
        case "zh-Hans":
            return .Chinese
        case "zh-HK":
            return .HongKong
        case "en":
            return .English
//        case "fr":
//            return .French
        case "ru":
            return .Russian
        case "ja":
            return .Japanese
        case "ko":
            return .Korean
//        case "vi":
//            return .Vietnamese
        default:
            return .English
        }
    }
    
    class func getLanguageName(_ type : Language) -> String {
        switch type {
        case .Chinese:
            return "中文（简体）"
        case .HongKong:
            return "中文（繁體）"
        case .English:
            return "English"
        case .Japanese:
            return "日本語"
        case .Korean:
            return "한국어"
        case .Russian:
            return "русский"
//        case .French:
//            return "français"
//        case .Vietnamese:
//            return "Tiếng Việt"
        }
    }
    
    class func getLanguageSymbol(_ type : Language) -> String {
        switch type {
        case .Chinese:
            return "CNY"
        case .HongKong:
            return "HKD"
        case .English:
            return "USD"
//        case .French:
//            return "EUR"
        case .Russian :
            return "RUB"
        case .Japanese:
            return "JPY"
        case .Korean:
            return "KRW"
//        case .Vietnamese:
//            return "VND"
        }
    }
    
}

extension String {
    var localized: String {
        return LocalizationTool.shared.valueWithKey(key: self)
    }
}

protocol AutoLocalizationProtocol {
    func setupLocalizationText()
}
