//
//  AIProgressHUD.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/26.
//

import Foundation

func showToast(_ title: String?) {
    showToast(title, nil)
}

func showToast(_ title: String?, _ showView: UIView?) {
    if let view = showView {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.hide(animated: true, afterDelay: 1)
    } else {
        guard let view = aiKeyWindow() else {
            return
        }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.hide(animated: true, afterDelay: 1)
    }
}

func aiKeyWindow() -> UIWindow? {
 
    var window: UIWindow? = nil
 
    if #available(iOS 13.0, *) {
        for windowScene:UIWindowScene in ((UIApplication.shared.connectedScenes as?  Set<UIWindowScene>)!) {
            if windowScene.activationState == .foregroundActive {
                window = windowScene.windows.first
              break
            }
        }
        return window
    } else {
        return  UIApplication.shared.keyWindow
    }
}
