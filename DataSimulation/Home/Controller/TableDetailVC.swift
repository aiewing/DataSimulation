//
//  TableDetailVC.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/30.
//

import UIKit
import G3GridView

class TableDetailVC: BaseVC {

    var tableInfo: TableInfoModel?
    var dataList: [TableDetailModel] = [TableDetailModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSettings()
        loadUI()
        loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        titleView.frame = CGRect(x: 0, y: NavBarHeight, width: view.width, height: 40)
        dataView.frame = CGRect(x: 0, y: NavBarHeight + 40, width: view.width, height: view.height - NavBarHeight - 40 - TabBarHeight)
    }
    
    override func rightButton1Tap() {
        guard let model = self.tableInfo else {
            return
        }
        let vc = AddTableDataVC()
        vc.tableInfo = model
        navigationController?.pushViewController(vc, animated: true)
        vc.addTableDataSucceedCb = { [weak self] in
            // 刷新界面
            self?.loadData()
        }
    }
    
    func loadSettings() {
        baseNavView.setNavDict([Nav_Title: "表名", Nav_Right_Img1: "table_add_pic"])
    }
    
    func loadUI() {
        view.addSubview(dataView)
        view.addSubview(titleView)
        
        view.bringSubviewToFront(baseNavView)
    }
    
    func loadData() {
        
        guard let model = self.tableInfo, let list = model.titleList else {
            return
        }
        
        // 先加载标题
        titleView.titleList = list
        
        let params = ["tid": model.tid ?? ""] as [String : Any]
        Network.request(.getTableDetail(params)) { [weak self](json) in
            let dList = json["dataList"].arrayValue.map({(dataJson) -> TableDetailModel in
                return TableDetailModel(jsonData: dataJson)
            })
            // 刷新数据
            self?.dataList = dList
            self?.refreshData()
        } failure: { (msg) in
            showToast(msg)
        }
    }
    
    // 刷新数据
    func refreshData() {
        dataView.setTableInfo(titleView.titleList, dataList)
    }
    
    // 长按数据回调
    func longPressDataTap(_ index: Int) {
        showAlertController(showCtl: self, alertStyle: .actionSheet, title: "提示", message: "请选择需要删除的数据", cancelTitle: "取消", otherButtonTitles: ["删除此行数据"], cancelCb: nil) { [weak self](clickIndex) in
            self?.deleteData(index)
        }
    }
    
    // 删除数据
    func deleteData(_ index: Int) {
        let model = dataList[index]
        let params = ["tid": model.tid ?? "", "did": model.did ?? ""] as [String : Any]
        Network.request(.deleteData(params)) { [weak self](json) in
            // 删除成功
            self?.dataList.remove(at: index)
            self?.refreshData()
        } failure: { (msg) in
            showToast(msg)
        }
    }
    
    // MARK: Lazy

    lazy var dataView: TableDataGridView = {
        let view = TableDataGridView()
        view.longPressTapCb = {[weak self] index in
            self?.longPressDataTap(index.row)
        }
        return view
    }()
      
    lazy var titleView: TableTitleGridView = {
        let view = TableTitleGridView()
        return view
    }()
}


