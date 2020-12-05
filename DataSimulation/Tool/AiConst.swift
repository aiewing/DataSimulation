//
//  AiConst.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/25.
//

import Foundation
import UIKit

let ScreenSize = UIScreen.main.bounds.size
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

let IsIPhoneX = (__CGSizeEqualToSize(CGSize(width: 375, height: 812), UIScreen.main.bounds.size) ||
                    __CGSizeEqualToSize(CGSize(width: 812, height: 375), UIScreen.main.bounds.size) ||
                    __CGSizeEqualToSize(CGSize(width: 414, height: 896), UIScreen.main.bounds.size) ||
                    __CGSizeEqualToSize(CGSize(width: 896, height: 414), UIScreen.main.bounds.size))

let StatusBarHeight = CGFloat(IsIPhoneX ? 44.0 : 20.0)
let NavBarHeight = StatusBarHeight + 44.0
let TabbarSafeBottomMargin = CGFloat(IsIPhoneX ? 34 : 0.0)
let TabBarHeight = TabbarSafeBottomMargin + 49.0

// 根据当前屏幕计算
func Scale(_ length: CGFloat) -> CGFloat {
    return length * ScreenWidth / 375.0
}

// 普通字体
func TextSystemFont(_ font: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: Scale(font))
}

// 加粗字体
func TextBoldFont(_ font: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: Scale(font))
}


typealias BlockNoParams = () -> Void
typealias BlockInt = (_ index: Int) -> Void
typealias BlockNameAndPassword = (_ name: String, _ password: String) -> Void
typealias BlockIndexPath = (_ index: IndexPath) -> Void


extension Array {
    // 防止数组越界
    subscript(index: Int, safe: Bool) -> Element? {
        if safe {
            if self.count > index {
                return self[index]
            } else {
                return nil
            }
        } else {
            return self[index]
        }
    }
}
