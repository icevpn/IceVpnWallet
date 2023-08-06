//
//  UILabel+extension.swift
//  ICE VPN
//
//  Created by tgg on 2023/5/30.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont? = nil, textColor: UIColor? = nil, text: String? = nil) {
        self.init()
        if let font = font {
            self.font = font
        }
        if let textColor = textColor {
            self.textColor = textColor
        }
        self.text = text
    }
    
    func adjustLine(space: CGFloat) {
        guard let attributedText = attributedText else {return}
        let attributedStr = NSMutableAttributedString(attributedString: attributedText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        attributedStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: attributedText.length))
        
        self.attributedText = attributedStr
    }
}

extension UILabel {
    func textAttributes() -> [NSAttributedString.Key : Any]? {
        guard let font = self.font,
              let color = self.textColor else {
            return nil
        }
        return [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color]
    }
}

