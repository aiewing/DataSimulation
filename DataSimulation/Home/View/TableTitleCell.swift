//
//  TableTitleCell.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/1.
//

import UIKit
import G3GridView

class TableTitleCell: GridViewCell {

    required init(frame: CGRect) {
        super.init(frame: frame)
        
        loadSettings()
        loadUI()
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel.frame = self.bounds
    }
    
    func loadSettings() {
        layer.borderWidth = 0.5
        layer.borderColor = MainColor.cgColor
    }
    
    func loadUI() {
        addSubview(textLabel)
    }
    
    // MARK: Lazy
    
    lazy var textLabel: UILabel = {
        let label = UILabel.label("", MainColor, TextSystemFont(15), .center)
        label.numberOfLines = 0
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
