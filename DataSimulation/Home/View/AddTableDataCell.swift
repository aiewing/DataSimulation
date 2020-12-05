//
//  AddTableDataCell.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/2.
//

import UIKit

class AddTableDataCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadUI()
        loadLayout()
    }
    
    func loadUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
    }
    
    func loadLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(Scale(10))
            make.height.equalTo(30)
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(120)
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.right).offset(Scale(10))
            make.height.equalTo(35)
            make.right.equalTo(self.contentView).offset(Scale(-10))
            make.centerY.equalTo(self.contentView)
        }
    }
    
    // MARK: Action
    
    // MARK: Lazy
    lazy var titleLabel: UILabel = {
        let label = UILabel.label("", TextBlackColor, TextSystemFont(15))
        return label
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.clearButtonMode = .always
        view.borderStyle = .roundedRect
        view.placeholder = "请输入数据"
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
