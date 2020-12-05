//
//  MeHeaderView.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/5.
//

import UIKit

class MeHeaderView: UIView {

    var settingsButtonTapCb: BlockNoParams?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadSettings()
        loadUI()
        loadLayout()
    }
    
    func loadSettings() {
        
    }
    
    func loadUI() {
        addSubview(settingsButton)
        addSubview(iconImgView)
        addSubview(nameLabel)
        addSubview(desLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        settingsButton.frame = CGRect(x: width - 44, y: NavBarHeight - 44, width: 44, height: 44)
        
        iconImgView.frame = CGRect(x: Scale(20), y: NavBarHeight, width: Scale(60), height: Scale(60))
        
        nameLabel.frame = CGRect(x: iconImgView.right + Scale(20), y: iconImgView.top + Scale(5), width: width - iconImgView.right - Scale(40), height: Scale(25))
        
        desLabel.frame = CGRect(x: nameLabel.left, y: nameLabel.bottom, width: nameLabel.width, height: Scale(30))
    }
    
    func loadLayout() {
        
    }
    
    @objc func settingsButtonClick() {
        guard let cb = self.settingsButtonTapCb else {
            return
        }
        cb()
    }
    
    lazy var settingsButton: UIButton = {
        let button = UIButton.button("setting_pic", self, #selector(settingsButtonClick))
        return button
    }()
    
    lazy var iconImgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.layer.cornerRadius = Scale(30)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel.label("名字", TextBlackColor, TextBoldFont(20))
        return label
    }()
    
    lazy var desLabel: UILabel = {
        let label = UILabel.label("还没有描述", TextGrayColor, TextSystemFont(15))
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
