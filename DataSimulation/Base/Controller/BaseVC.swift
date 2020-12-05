//
//  BaseVC.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/26.
//

import UIKit

class BaseVC: UIViewController {
    
    // MARK: Public
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = VCBgColor
        navigationController?.navigationBar.isHidden = true
        view.addSubview(baseNavView)
        baseNavView.frame = CGRect(x: 0, y: 0, width: view.width, height: NavBarHeight)
        baseNavView.setNavDict([Nav_Left_Img1: "back"])
    }
    
    override func viewWillLayoutSubviews() {
        baseNavView.frame = CGRect(x: 0, y: 0, width: view.width, height: NavBarHeight)
    }
    
    // MARK: Pro
    func leftButton1Tap() {
        navigationController?.popViewController(animated: true)
    }
    
    func rightButton1Tap() {
        
    }
    
    lazy var baseNavView: BaseNavView = {
        let view = BaseNavView()
        view.leftButton1TapCb = {[weak self] in
            self?.leftButton1Tap()
        }
        view.rightButton1TapCb = {[weak self] in
            self?.rightButton1Tap()
        }
        return view
    }()
}
