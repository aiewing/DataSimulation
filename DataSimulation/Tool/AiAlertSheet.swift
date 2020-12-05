//
//  AiAlertSheet.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/3.
//

import Foundation

func showAlertController(showCtl: UIViewController, alertStyle: UIAlertController.Style, title: String, message: String, cancelTitle: String?, otherButtonTitles: [String?]?, cancelCb: BlockNoParams?, otherCb: @escaping BlockInt) {
    let vc = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
    
    if let cancelStr = cancelTitle {
        let sureAction = UIAlertAction(title: cancelStr, style: .cancel) { (action) in
            if let cb = cancelCb {
                cb()
            }
        }
        vc.addAction(sureAction)
    }
    
    if let otherTitles = otherButtonTitles {
        for i in 0..<otherTitles.count {
            if let title = otherTitles[i] {
                let action = UIAlertAction(title: title, style: .default) { (action) in
                    otherCb(i)
                }
                vc.addAction(action)
            }
        }
    }
    showCtl.present(vc, animated: true, completion: nil)
}
