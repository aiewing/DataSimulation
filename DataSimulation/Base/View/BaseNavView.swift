//
//  BaseNavView.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/26.
//

import UIKit

let Nav_Title = "Nav_Title"
let Nav_Left_Title1 = "Nav_Left_Title1"
let Nav_Left_Img1 = "Nav_Left_Img1"
let Nav_Right_Title1 = "Nav_Right_Title1"
let Nav_Right_Img1 = "Nav_Right_Img1"

class BaseNavView: UIView {

    var rightButton1TapCb: BlockNoParams?
    var leftButton1TapCb: BlockNoParams?
    
    // 合并字典 并取新值
    func setNavDict(_ dict: [String: String]?) {
        guard let dic = dict else {
            return
        }
        navDict = navDict.merging(dic) {(_, new) in new}
        self.setNeedsLayout()
    }
    
    private var navDict = [String: String]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadSettings()
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSettings() {
        backgroundColor = MainColor
    }
    
    func loadUI() {
        addSubview(bgImgView)
        addSubview(titleLabel)
        addSubview(leftButton1)
        addSubview(rightButton1)
    }
    
    override func layoutSubviews() {
        
        bgImgView.frame = bounds
        
        titleLabel.frame = CGRect(x: 54, y: height - 44, width: width - 108, height: 44)
        
        leftButton1.frame = CGRect(x: 0, y: titleLabel.top, width: 44, height: 44)
        rightButton1.frame = CGRect(x: width - 44, y: titleLabel.top, width: 44, height: 44)
        
        if let title = navDict[Nav_Title] {
            titleLabel.text = title
        }
        
        var flag = false
        if let leftTitle1 = navDict[Nav_Left_Title1], leftTitle1 != "" {
            leftButton1.setTitle(leftTitle1, for: .normal)
            leftButton1.setImage(nil, for: .normal)
            leftButton1.setImage(nil, for: .highlighted)
            flag = (flag || true)
        }
        if let leftImg1 = navDict[Nav_Left_Img1], leftImg1 != "" {
            leftButton1.setTitle("", for: .normal)
            leftButton1.setImage(UIImage(named: leftImg1), for: .normal)
            leftButton1.setImage(UIImage(named: leftImg1), for: .highlighted)
            flag = (flag || true)
        }
        leftButton1.isHidden = !flag
        
        flag = false
        if let rightTitle1 = navDict[Nav_Right_Title1], rightTitle1 != "" {
            rightButton1.setTitle(rightTitle1, for: .normal)
            rightButton1.setImage(nil, for: .normal)
            rightButton1.setImage(nil, for: .highlighted)
            flag = (flag || true)
        }
        if let rightImg1 = navDict[Nav_Right_Img1], rightImg1 != "" {
            rightButton1.setTitle("", for: .normal)
            rightButton1.setImage(UIImage(named: rightImg1), for: .normal)
            rightButton1.setImage(UIImage(named: rightImg1), for: .highlighted)
            flag = (flag || true)
        }
        rightButton1.isHidden = !flag
    }
    
    // MARK: Action
    
    @objc func rightButton1Click() {
        guard let cb = self.rightButton1TapCb else {
            return
        }
        cb()
    }
    
    @objc func leftButton1Click() {
        guard let cb = self.leftButton1TapCb else {
            return
        }
        cb()
    }
    
    // MARK: Lazy
    
    lazy var bgImgView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.label("", .white, TextBoldFont(22), .center)
        return label
    }()
    
    lazy var rightButton1: UIButton = {
        let button = UIButton.button("", .white, TextSystemFont(17))
        button.addTap(self, #selector(rightButton1Click))
        button.isHidden = true
        return button
    }()
    
    lazy var leftButton1: UIButton = {
        let button = UIButton.button("", .white, TextSystemFont(17))
        button.addTap(self, #selector(leftButton1Click))
        button.setImage(UIImage(named: "back"), for: .normal)
        button.setImage(UIImage(named: "back"), for: .highlighted)
        return button
    }()
}
