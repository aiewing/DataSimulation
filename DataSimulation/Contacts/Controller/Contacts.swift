//
//  Contacts.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/5.
//

import UIKit

class Contacts: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSettings()
    }
    
    func loadSettings() {
        baseNavView.setNavDict([Nav_Title: "通讯", Nav_Left_Img1: "", Nav_Right_Img1: "updata_pic"])
    }
    
    func loadUI() {

    }
    
    func loadLayout() {
        
    }
    
    // 更新通讯录
    override func rightButton1Tap() {
        super.rightButton1Tap()
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
