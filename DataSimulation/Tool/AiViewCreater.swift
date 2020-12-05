//
//  AiViewCreater.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/25.
//

import Foundation
import UIKit

extension UILabel {
    class func label(_ text: String?, _ textColor: UIColor?, _ textFont: UIFont?) -> UILabel {
        let label = UILabel(frame: .zero)
        if let aText = text {
            label.text = aText
        }
        if let aTextColor = textColor {
            label.textColor = aTextColor
        }
        if let aTextFont = textFont {
            label.font = aTextFont
        }
        return label
    }
    
    class func label(_ text: String?, _ textColor: UIColor?, _ textFont: UIFont?, _ textAlignment: NSTextAlignment?) -> UILabel {
        let label = UILabel(frame: .zero)
        if let aText = text {
            label.text = aText
        }
        if let aTextColor = textColor {
            label.textColor = aTextColor
        }
        if let aTextFont = textFont {
            label.font = aTextFont
        }
        if let aTextAlignment = textAlignment {
            label.textAlignment = aTextAlignment
        }
        return label
    }
}

extension UIButton {
    
    class func button(_ text: String?, _ textColor: UIColor?, _ textFont: UIFont?) -> UIButton {
        let button = UIButton(frame: CGRect.zero)
        if let aTitle = text {
            button.setTitle(aTitle, for: .normal)
        }
        if let aTextColor = textColor {
            button.setTitleColor(aTextColor, for: .normal)
        }
        if let aTextFont = textFont {
            button.titleLabel?.font = aTextFont
        }
        return button
    }
    
    class func button(_ text: String?, _ textColor: UIColor?, _ textFont: UIFont?, _ target: Any?, _ action: Selector?) -> UIButton {
        let button = UIButton(frame: CGRect.zero)
        if let aTitle = text {
            button.setTitle(aTitle, for: .normal)
        }
        if let aTextColor = textColor {
            button.setTitleColor(aTextColor, for: .normal)
        }
        if let aTextFont = textFont {
            button.titleLabel?.font = aTextFont
        }
        if let aTarget = target, let aAction = action {
            button.addTarget(aTarget, action: aAction, for: .touchUpInside)
        }
        return button
    }
    
    class func button(_ image: String?, _ target: Any?, _ action: Selector?) -> UIButton {
        let button = UIButton(frame: CGRect.zero)
        if let aImage = image {
            button.setImage(UIImage(named: aImage), for: .normal)
            button.setImage(UIImage(named: aImage), for: .highlighted)
        }
        if let aTarget = target, let aAction = action {
            button.addTarget(aTarget, action: aAction, for: .touchUpInside)
        }
        return button
    }
}


extension UIView {
    var top: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.origin.y = newValue
            self.frame = newFrame
        }
        get {
            return self.frame.minY
        }
    }
    
    var bottom: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.origin.y = newValue - newFrame.size.height
            self.frame = newFrame
        }
        get {
            return self.frame.maxY
        }
    }
    
    var left: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.origin.x = newValue
            self.frame = newFrame
        }
        get {
            return self.frame.minX
        }
    }
    
    var right: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.origin.x = newValue - newFrame.size.width
            self.frame = newFrame
        }
        get {
            return self.frame.maxX
        }
    }
    
    var width: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.size.width = newValue
            self.frame = newFrame
        }
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.size.height = newValue
            self.frame = newFrame
        }
        get {
            return self.frame.size.height
        }
    }
    
    var centerX: CGFloat {
        set {
            var newCenter = self.center
            newCenter.x = newValue
            self.center = newCenter
        }
        get {
            return self.frame.midX
        }
    }
    
    var centerY: CGFloat {
        set {
            var newCenter = self.center
            newCenter.y = newValue
            self.center = newCenter
        }
        get {
            return self.frame.midY
        }
    }
    
    // 添加点击手势
    func addTap(_ target: Any?, _ action: Selector?) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tap)
    }
    
    // 添加点击手势
    func addLongPress(_ target: Any?, _ action: Selector?) {
        let tap = UILongPressGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tap)
    }
}
