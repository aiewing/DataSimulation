//
//  AddTableCell.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/27.
//

import UIKit

class AddTableCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadUI()
        loadLayout()
    }
    
    func loadUI() {
        contentView.addSubview(textField)
        contentView.addSubview(upButton)
        contentView.addSubview(downButton)
    }
    
    func loadLayout() {
        downButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(Scale(-10))
        }
        
        upButton.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(self.downButton)
            make.right.equalTo(self.downButton.snp.left)
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(Scale(10))
            make.height.equalTo(35)
            make.right.equalTo(self.upButton.snp.left).offset(Scale(-10))
            make.centerY.equalTo(self.contentView)
        }
    }
    
    // MARK: Action
    
    @objc func upButtonClick() {
        
    }
    
    @objc func downButtonClick() {
        
    }
    
    // MARK: Lazy
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.clearButtonMode = .always
        view.borderStyle = .roundedRect
        view.placeholder = "请输入列表列名"
        return view
    }()
    
    lazy var upButton: UIButton = {
        let button = UIButton.button("order_up", self, #selector(upButtonClick))
        return button
    }()
    
    lazy var downButton: UIButton = {
        let button = UIButton.button("order_down", self, #selector(downButtonClick))
        return button
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
