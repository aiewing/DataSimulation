//
//  BaseTabBarView.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/3.
//

import UIKit

enum BaseTabBarItemStatusType {
    case normal
    case selected
}

class BaseTabBarItemView: UIView {
    
    var title = ""
    var normalTitleColor = UIColor.gray
    var selectedTitleColor = UIColor.black
    var normalImage = ""
    var selectedImage = ""
    var selectStatus = UIControl.State.normal
    
    func setTabBarItemInfo(title: String?, normalTitleColor: UIColor?, selectedTitleColor: UIColor?, normalImage: String?, selectedImage: String?) {
        if let aTitle = title {
            self.title = aTitle
        }
        if let aNormalTitleColor = normalTitleColor {
            self.normalTitleColor = aNormalTitleColor
        }
        if let aSelectedTitleColor = selectedTitleColor {
            self.selectedTitleColor = aSelectedTitleColor
        }
        if let aNormalImage = normalImage {
            self.normalImage = aNormalImage
        }
        if let aSelectedImage = selectedImage {
            self.selectedImage = aSelectedImage
        }
        
        titleLabel.text = self.title
        setSelectStatus(.normal)
    }
    
    func setSelectStatus(_ status: BaseTabBarItemStatusType) {
        if status == .normal {
            titleLabel.textColor = normalTitleColor
            imgView.image = UIImage(named: normalImage)
        } else {
            titleLabel.textColor = selectedTitleColor
            imgView.image = UIImage(named: selectedImage)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadUI()
    }
    
    func loadUI() {

        addSubview(imgView)
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imgView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        imgView.centerX = width / 2.0
        imgView.top = 4.0
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: width, height: 15)
        titleLabel.top = imgView.bottom + 2
    }
    
    
    // MARK: Lazy
    
    lazy var imgView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BaseTabBarView: UIView {

    var itemTapCb: BlockInt?
    
    // 设置图片和字体颜色
    func setTabBarInfo(titleList: [String?], normalTitleColorList: [UIColor?], selectedTitleColorList: [UIColor?], normalImageList: [String?], selectedImageList: [String?]) {
        
        itemList.removeAll()
        for i in 0..<titleList.count {
            let item = BaseTabBarItemView(frame: .zero)
            item.tag = 50 + i
            item.setTabBarItemInfo(title: titleList[i, true] as? String, normalTitleColor: normalTitleColorList[i, true] as? UIColor, selectedTitleColor: selectedTitleColorList[i, true] as? UIColor, normalImage: normalImageList[i, true] as? String, selectedImage: selectedImageList[i, true] as? String)
            addSubview(item)
            itemList.append(item)
            
            // 默认第一个选择
            if i == 0 {
                item.setSelectStatus(.selected)
            } else {
                item.setSelectStatus(.normal)
            }
            
            item.addTap(self, #selector(itemTap))
        }
        setNeedsLayout()
    }
    
    var itemList = [BaseTabBarItemView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadSettings()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let itemWidth = width / max(CGFloat(itemList.count), 1.0)
        for i in 0..<itemList.count {
            let item = itemList[i]
            item.frame = CGRect(x: itemWidth * CGFloat(i), y: 0, width: itemWidth, height: height)
        }
    }
    
    func loadSettings() {
        backgroundColor = .white
    }
    
    func loadUI() {
        
    }
    
    func loadLayout() {
        
    }
    
    @objc func itemTap(tapGe: UITapGestureRecognizer) {
        guard let tag = tapGe.view?.tag, let cb = self.itemTapCb else {
            return
        }
        cb(tag - 50)
        
        for i in 0..<itemList.count {
            let item = itemList[i]
            if i == tag - 50 {
                item.setSelectStatus(.selected)
            } else {
                item.setSelectStatus(.normal)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
