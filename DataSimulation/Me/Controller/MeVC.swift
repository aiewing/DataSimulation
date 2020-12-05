//
//  MeVC.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/26.
//

import UIKit

class MeVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSettings()
        loadUI()
    }
    
    func loadSettings() {
        baseNavView.isHidden = true
        view.backgroundColor = .white
    }
    
    func loadUI() {
        view.addSubview(headerView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.width, height: 200)
    }
    
    func settingsButtonTap() {
        let vc = SettingsVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    lazy var headerView: MeHeaderView = {
        let view = MeHeaderView()
        view.settingsButtonTapCb = {[weak self] in
            self?.settingsButtonTap()
        }
        return view
    }()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
