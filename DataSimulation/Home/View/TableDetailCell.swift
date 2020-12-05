//
//  TableDetailCell.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/1.
//

import UIKit
import G3GridView

class TableDetailCell: GridViewCell {

    public var longPressTapCb: BlockNoParams?
    
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
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func loadUI() {
        addSubview(textLabel)
    }
    
    @objc func viewTap() {
        guard let cb = self.longPressTapCb else {
            return
        }
        cb()
    }
    
    // MARK: Lazy
    
    lazy var textLabel: UILabel = {
        let label = UILabel.label("", TextGrayColor, TextSystemFont(13), .center)
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.addLongPress(self, #selector(viewTap))
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
