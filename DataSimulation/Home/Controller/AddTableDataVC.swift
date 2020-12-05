//
//  AddTableDataVC.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/2.
//

import UIKit

class AddTableDataVC: BaseVC {

    var addTableDataSucceedCb: BlockNoParams?
    var titleList: [String] = [String]()
    
    var tableInfo: TableInfoModel = TableInfoModel(jsonData: "") {
        didSet(old) {
            guard let list = tableInfo.titleList else {
                return
            }
            titleList = list
            rowLabel.text = tableInfo.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSettings()
        loadUI()
    }
    
    // 确认添加列表
    override func rightButton1Tap() {

        var dataList = [String]()
        for i in 0..<titleList.count {
            let addCell = addTableView.cellForRow(at: IndexPath(row: i, section: 0)) as? AddTableDataCell
            guard let cell = addCell, let text = cell.textField.text else {
                dataList.append("")
                continue
            }
            dataList.append(text)
        }

        let params = ["tid": tableInfo.tid ?? "", "dataList": dataList] as [String : Any]
        Network.request(.createNewData(params)) { [weak self](json) in
            showToast("添加成功")
            self?.navigationController?.popViewController(animated: true)
            guard let cb = self?.addTableDataSucceedCb else {
                return
            }
            cb()
        } failure: { (msg) in
            showToast(msg)
        }

    }
    
    func loadSettings() {
        baseNavView.setNavDict([Nav_Title: "添加数据", Nav_Right_Title1: "确认"])
        view.backgroundColor = .white
    }
    
    func loadUI() {
        view.addSubview(rowLabel)
        view.addSubview(addTableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        rowLabel.frame = CGRect(x: Scale(10), y: NavBarHeight + Scale(5), width: view.width - Scale(10) , height: Scale(30))
        
        addTableView.frame = CGRect(x: 0, y: rowLabel.bottom + Scale(5), width: ScreenWidth, height: ScreenHeight - TabbarSafeBottomMargin - rowLabel.bottom - Scale(5))
    }
    

    // MARK: Lazy
    lazy var rowLabel: UILabel = {
        let label = UILabel.label("列表列名", TextBlackColor, TextBoldFont(17))
        return label
    }()
    
    lazy var addTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(AddTableDataCell.self, forCellReuseIdentifier: "AddTableDataCell")
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.rowHeight = 44
        view.delegate = self
        view.dataSource = self
        view.tableFooterView = UIView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.isScrollEnabled = false
        return view
    }()
}

extension AddTableDataVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddTableDataCell = tableView.dequeueReusableCell(withIdentifier: "AddTableDataCell") as! AddTableDataCell
        cell.backgroundColor = .white
        cell.titleLabel.text = titleList[indexPath.row]
        return cell
    }
    
    
}
