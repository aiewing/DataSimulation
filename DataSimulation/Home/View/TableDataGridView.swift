//
//  TableDataGridView.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/2.
//

import UIKit
import G3GridView

class TableDataGridView: UIView {

    var titleList: [String] = [String]()
    var dataList: [TableDetailModel] = [TableDetailModel]()
    var longPressTapCb: BlockIndexPath?

    public func setTableInfo(_ tList: [String], _ dList: [TableDetailModel]) {
        titleList = tList
        dataList = dList
        self.dataListView.reloadData()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        loadSettings()
        loadUI()
    }

    func loadSettings() {
        backgroundColor = .white
    }

    func loadUI() {
        addSubview(dataListView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        dataListView.frame = self.bounds
    }

    // MARK: Lazy

    lazy var dataListView: GridView = {
        let view = GridView()
        view.dataSource = self
        view.delegate = self
        view.register(TableDetailCell.self, forCellWithReuseIdentifier: "TableDetailCell")
        view.isInfinitable = false
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableDataGridView: GridViewDataSource, GridViewDelegate {
    func numberOfColumns(in gridView: GridView) -> Int {
        return titleList.count
    }

    func gridView(_ gridView: GridView, numberOfRowsInColumn column: Int) -> Int {
        // 默认先加载100行
        return max(100, self.dataList.count)
    }

    func gridView(_ gridView: GridView, cellForRowAt indexPath: IndexPath) -> GridViewCell {
        let cell: TableDetailCell = gridView.dequeueReusableCell(withReuseIdentifier: "TableDetailCell", for: indexPath) as! TableDetailCell

        if indexPath.row >= dataList.count {
            cell.textLabel.text = ""
        } else {
            let model = dataList[indexPath.row]
            if let detailModel = model.dataList {
                cell.textLabel.text = detailModel[indexPath.section]
            } else {
                cell.textLabel.text = ""
            }
        }
        
        // 长按回调
        cell.longPressTapCb = {[weak self] in
            if let cb = self?.longPressTapCb {
                cb(indexPath)
            }
        }
        
        return cell
    }

    func gridView(_ gridView: GridView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func gridView(_ gridView: GridView, widthForColumn column: Int) -> CGFloat {
        return ScreenWidth / 5.0
    }
}
