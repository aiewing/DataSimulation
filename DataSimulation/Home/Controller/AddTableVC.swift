//
//  AddTableVC.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/27.
//

import UIKit

class AddTableVC: BaseVC {

    var addTableSucceedCb: BlockNoParams?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSettings()
        loadUI()
    }
    
    // 确认添加列表
    override func rightButton1Tap() {
        let name = nameTextField.text!
        if name.count < 1 || name.count > 100 {
            showToast("表名只能在1-100个字符之间")
            return
        }
        
        var titleList = [String]()
        for i in 0..<5 {
            let addCell = addTableView.cellForRow(at: IndexPath(row: i, section: 0)) as? AddTableCell
            guard let cell = addCell, let text = cell.textField.text else {
                continue
            }
            titleList.append(text)
        }
        
        if titleList.count == 0 {
            showToast("至少需要有一个列名")
            return
        }
        
        let params = ["name": name, "titleList": titleList] as [String : Any]
        Network.request(.createNewTable(params)) { [weak self](json) in
            showToast("添加成功")
            self?.navigationController?.popViewController(animated: true)
            guard let cb = self?.addTableSucceedCb else {
                return
            }
            cb()
        } failure: { (msg) in
            showToast(msg)
        }

    }
    
    func loadSettings() {
        baseNavView.setNavDict([Nav_Title: "添加列表", Nav_Right_Title1: "确认"])
        view.backgroundColor = .white
    }
    
    func loadUI() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(rowLabel)
        view.addSubview(addTableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        nameLabel.frame = CGRect(x: Scale(10), y: NavBarHeight + Scale(5), width: ScreenWidth - Scale(10), height: 30)
        
        nameTextField.frame = CGRect(x: Scale(10), y: nameLabel.bottom + Scale(5), width: ScreenWidth - Scale(108), height: 35)
        
        rowLabel.frame = CGRect(x: nameLabel.left, y: nameTextField.bottom + Scale(5), width: nameLabel.width, height: nameLabel.height)
        
        addTableView.frame = CGRect(x: 0, y: rowLabel.bottom + Scale(5), width: ScreenWidth, height: ScreenHeight - TabbarSafeBottomMargin - NavBarHeight)
    }
    

    // MARK: Lazy
    lazy var nameLabel: UILabel = {
        let label = UILabel.label("列表名称", TextBlackColor, TextBoldFont(20))
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let view = UITextField()
        view.clearButtonMode = .always
        view.borderStyle = .roundedRect
        view.placeholder = "请输入列表名称"
        return view
    }()
    
    lazy var rowLabel: UILabel = {
        let label = UILabel.label("列表列名", TextBlackColor, TextBoldFont(20))
        return label
    }()
    
    lazy var addTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(AddTableCell.self, forCellReuseIdentifier: "AddTableCell")
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

extension AddTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddTableCell = tableView.dequeueReusableCell(withIdentifier: "AddTableCell") as! AddTableCell
        cell.backgroundColor = .white
        return cell
    }
    
    
}
