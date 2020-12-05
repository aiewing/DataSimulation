//
//  TabBarVC.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/26.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadVC()
        loadTabBar()
        loadData()
    }
    
    func loadVC() {
        let homeNavVC = BaseNavVC(rootViewController: HomeVC())
        homeNavVC.title = "主页"
        let mailListNavVC = BaseNavVC(rootViewController: Contacts())
        mailListNavVC.title = "通讯"
        let meNavVC = BaseNavVC(rootViewController: MeVC())
        meNavVC.title = "我的"
        
        self.viewControllers = [homeNavVC, mailListNavVC, meNavVC]
    }
    
    func loadTabBar() {
//        tabBar.isHidden = true;
        view.addSubview(tabBarView)
    }
    
    func loadData() {
        tabBarView.setTabBarInfo(titleList: ["首页", "通讯", "我的"], normalTitleColorList: [TextGrayColor, TextGrayColor, TextGrayColor], selectedTitleColorList: [MainColor, MainColor, MainColor], normalImageList: ["home_normal", "list_normal", "me_normal"], selectedImageList: ["home_selected", "list_selected", "me_selected"])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tabBarView.frame = CGRect(x: 0, y: view.height - TabBarHeight, width: view.width, height: TabBarHeight)
    }
    
    // 切换
    func tabBarItemTap(_ index: Int) {
        selectedIndex = index
    }
    
    lazy var tabBarView: BaseTabBarView = {
        let view = BaseTabBarView(frame: .zero)
        view.itemTapCb = {[weak self]index in
            self?.tabBarItemTap(index)
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
