//
//  TableTitleGridView.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/1.
//

import UIKit
import G3GridView

class TableTitleGridView: UIView {

    public var titleList: [String] = [String]() {
        didSet(oldCurrent) {
            self.titleListView.reloadData()
        }
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
        addSubview(titleListView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleListView.frame = self.bounds
    }
    
    // MARK: Lazy
    
    lazy var titleListView: GridView = {
        let view = GridView()
        view.dataSource = self
        view.delegate = self
        view.register(TableTitleCell.self, forCellWithReuseIdentifier: "TableTitleCell")
        view.isInfinitable = false
        view.bounces = false
//        view.contentInset.top = NavBarHeight
//        view.contentOffset = CGPoint(x: 0, y: NavBarHeight)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableTitleGridView: GridViewDataSource, GridViewDelegate {
    func numberOfColumns(in gridView: GridView) -> Int {
        return titleList.count
    }
    
    func gridView(_ gridView: GridView, numberOfRowsInColumn column: Int) -> Int {
        return 1
    }
    
    func gridView(_ gridView: GridView, cellForRowAt indexPath: IndexPath) -> GridViewCell {
        let cell: TableTitleCell = gridView.dequeueReusableCell(withReuseIdentifier: "TableTitleCell", for: indexPath) as! TableTitleCell
        cell.textLabel.text = titleList[indexPath.section]
        return cell
    }
    
    func gridView(_ gridView: GridView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func gridView(_ gridView: GridView, widthForColumn column: Int) -> CGFloat {
        if titleList.count == 0 {
            return ScreenWidth
        } else if titleList.count > 5 {
            return ScreenWidth / 5.0
        } else {
            return ScreenWidth / CGFloat(titleList.count)
        }
    }
}

