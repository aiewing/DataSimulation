//
//  SettingsVC.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/6.
//

import UIKit

class SettingsVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSettings()
        loadUI()
    }
    
    func loadSettings() {
        baseNavView.setNavDict([Nav_Title: "设置"])
    }
    
    func loadUI() {
        view.addSubview(logoutButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        logoutButton.frame = CGRect(x: Scale(20), y: NavBarHeight + Scale(20), width: view.width - Scale(40), height: 40)
    }
    
    // 退出登录
    @objc func logoutButtonClick() {
        showAlertController(showCtl: self, alertStyle: .alert, title: "提示", message: "是否确认退出登录？", cancelTitle: "取消", otherButtonTitles: ["确认"], cancelCb: nil) { (index) in
            self.logout()
        }
    }
    
    func logout() {
        Network.request(.logout([:])) { [weak self] (json) in
            // 退出登录成功 删除信息
            UserDefaults.LoginInfo.set(value: "", forKey: .session)
            self?.pushToLoginVC()
        } failure: { (msg) in
            showToast(msg)
        }
    }
    
    func pushToLoginVC() {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.pushToLoginVC()
    }
    
    lazy var logoutButton: UIButton = {
        let button = UIButton.button("退出登录", .white, TextBoldFont(17), self, #selector(logoutButtonClick))
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.backgroundColor = .red
        return button
    }()

}
