//
//  HomeVC.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/26.
//

import UIKit

class HomeVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSettings()
        loadUI()
        loadLayout()
        loadData()
    }
    
    override func rightButton1Tap() {
        let vc = AddTableVC()
        navigationController?.pushViewController(vc, animated: true)
        vc.addTableSucceedCb = {[weak self] in
            self?.loadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableTableView.frame = CGRect(x: 0, y: NavBarHeight, width: view.width, height: view.height - NavBarHeight - TabBarHeight)
    }
    
    func loadSettings() {
        baseNavView.setNavDict([Nav_Title: "主页", Nav_Right_Img1: "table_add_pic", Nav_Left_Img1: ""])
    }
    
    func loadUI() {
        view.addSubview(tableTableView)
    }
    
    func loadLayout() {
        
    }
    
    func loadData() {
        Network.request(.getTableList([:])) { [weak self](json) in
            let tableList = json.arrayValue.map({(dataJson) -> TableInfoModel in
                return TableInfoModel(jsonData: dataJson)
            })

            // 刷新界面
            self?.tableInfoList = tableList
            self?.tableTableView.reloadData()
        } failure: { (msg) in
            showToast(msg)
        }
    }
    
    func deleteTable(_ index: Int) {
        let model = self.tableInfoList[index]
        guard let tid = model.tid else {
            return
        }
        let params = ["tid": tid]
        Network.request(.deleteTable(params)) { (json) in
            // 成功就删除数据
            self.tableInfoList.remove(at: index)
            self.tableTableView.reloadData()
            showToast("删除成功")
        } failure: { (msg) in
            showToast(msg)
        }

    }
    
    // MARK: Lazy
    
    var tableInfoList = [TableInfoModel]()
    
    lazy var tableTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(TableListCell.self, forCellReuseIdentifier: "TableListCell")
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.tableFooterView = UIView()
        return view
    }()

}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableListCell = tableView.dequeueReusableCell(withIdentifier: "TableListCell") as! TableListCell
        cell.backgroundColor = .white
        let model = tableInfoList[indexPath.row]
        cell.textLabel?.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let model = tableInfoList[indexPath.row]
        let vc = TableDetailVC()
        vc.tableInfo = model
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlertController(showCtl: self, alertStyle: .alert, title: "提示", message: "确定要删除这个表？", cancelTitle: "取消", otherButtonTitles: ["确定"], cancelCb: nil) { (index) in
                // 删除这个表
                self.deleteTable(indexPath.row)
            }
        }
    }
}
