//
//  AiColor.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/26.
//

import Foundation
import UIKit


func RGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
}

func RGBA(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}


let MainColor = RGB(18, 150, 219)
let TextGrayColor = RGB(40, 40, 40)
let VCBgColor = RGB(245, 245, 245)
let TextBlackColor = RGB(20, 20, 20)
